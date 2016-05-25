class Coctaile < ActiveRecord::Base

  mount_uploader :image, CoctaileImageUploader

  has_many :ingredients
  has_many :products, through: :ingredients

  before_save { self.name = name.titleize}
  before_save  :set_alcohol_status!

  enum alcoholic:[:alcohol, :unalcohol]

  validates :name, presence: true, allow_blank: false

  validate :validate_coctaile

  accepts_nested_attributes_for :ingredients,
    reject_if: lambda { |attributes|
       attributes[:value].blank? && attributes[:product_id].blank? }

  def validate_coctaile
    drink = 0
    equal_products = 0
    ingredients.select{ |ingredient|
      if ingredient.product.present?
        if ingredient.product.product_type == 'drink'
          drink = drink + 1
        end
      end

      ingredients.each do |ingredient_p|
        if ingredient_p.product_id == ingredient.product_id
          equal_products = equal_products + 1
        end
      end
    }


    if drink < 1
      errors.add(:coctaile, " must have more drinks")
    end
    if ingredients.size == 1
      errors.add(:coctaile, " must have more ingredients")
    end
    if equal_products > ingredients.size
      errors.add(:coctaile, " can't have equal products")
    end
  end


  def value
    ingredients.inject(0) { |sum, ingredient|
      sum + (ingredient.product.product_type == 'drink' ? ingredient.value : 0)
    }
  end

  def price
    ingredients.inject(0) { |price, ingredient|
      price + (ingredient.value / ingredient.product.min_value) *
        ingredient.product.price
    }
  end

private

  def set_alcohol_status!
    alc_ingredients = ingredients.select{ |ingredient|
        ingredient.product.have_alc?
    }
    self.have_alc = alc_ingredients.size > 0 ? 1 : 0

  end


end
