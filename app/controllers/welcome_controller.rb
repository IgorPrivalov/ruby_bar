class WelcomeController < ApplicationController

  before_filter :find_item, only: [:show_coctaile]


  def index
    @coctailes = Coctaile.includes(:ingredients, :products)
    find_shorts_and_longs @coctailes
  end

  def show
    @coctailes = Coctaile.joins(:products).where(ingredients: {product_id: params[:id]}).distinct
    @product = Product.find_by id: params[:id]
    find_shorts_and_longs @coctailes
  end

  def show_coctaile
    
  end

private

  def find_item
	@coctaile = Coctaile.find_by id: params[:id]
  end	

  def find_shorts_and_longs coctailes
    @shorts = []
    @longs = []
    coctailes.each do |coctaile|
      if coctaile.have_alc
        if coctaile.value <= 100
          @shorts.push coctaile
        else
          @longs.push coctaile
        end
      end
    end
  end

end
