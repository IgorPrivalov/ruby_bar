class Product < ActiveRecord::Base

  mount_uploader :image, ProductImageUploader

  validates :name, :cost_price, :min_value, :product_type, presence: true
  validates :name, presence: true, allow_blank: false
  validates :cost_price, :min_value, numericality: {greater_than: 0 }

  has_many :ingredients

  @@tax = 0.04
  @@markup_percent = 0.5

  @@product_types = ['drink', 'not drink']

  def price
    cost_price + markup + (markup * @@tax)
  end

  def markup
    cost_price * @@markup_percent
  end

  def self.product_types
    @@product_types
  end

  def have_alc?
    self.have_alc == 1
  end

end
