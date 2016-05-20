class Admin::ProductsController < Admin::ApplicationController

  before_filter :find_item, only: [:edit, :update, :destroy, :show]


  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create item_params
    redirect_to action: 'index'
  end

  def item_params
    params.require(:product).
        permit(:id, :name, :cost_price, :min_value, :have_alc, "product_type", :image)
  end

  def edit

  end

  def update
    @product.update_attributes item_params
    if @product.errors.empty?
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to action: 'index'
  end

  private

  def find_item
    @product = Product.where(id: params[:id]).first
  end

end
