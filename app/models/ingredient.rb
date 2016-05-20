class Ingredient < ActiveRecord::Base

  validates :value, numericality: {greater_than: 0}
  validates :product_id, presence: true, allow_blank: false

  validate :validate_value

  belongs_to :coctaile
  belongs_to :product

  def validate_value
    if product.present? && value != nil && value < product.min_value
      errors.add(:value, " for product '#{product.name}' must be greater '#{product.min_value }'")
    end
  end

  def price
    (value / product.min_value) * product.price
  end

end
