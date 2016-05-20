class Admin::CoctailesController < Admin::ApplicationController

  INGREDIENT_MAX_COUNT = 5

  before_filter :find_item, only: [:edit, :update, :destroy, :show]

  def prepare_ingredient_items
    (INGREDIENT_MAX_COUNT - @coctaile.ingredients.count).times{
      @coctaile.ingredients.build
    }
  end

  def index
    @coctailes = Coctaile.includes(:ingredients, :products)
  end

  def new
    @coctaile = Coctaile.new
    prepare_ingredient_items
  end

  def create
    @coctaile = Coctaile.create item_params
    if @coctaile.errors.empty?
      flash[:success] = "Coctaile \'#{@coctaile.name.humanize}\' was created successfully"
      redirect_to action: 'index'
    else
      flash[:warning] = @coctaile.errors.full_messages.to_sentence
      render :new
    end
  end

  def item_params
    params.require(:coctaile).permit(:id, :name, :image, :value, ingredients_attributes: [:id, :value, :product_id, :coctaile_id])
  end

  def edit
    prepare_ingredient_items
  end

  def destroy
    @coctaile.destroy
    redirect_to action: 'index'
  end

  def update
    @coctaile.update_attributes item_params
    if @coctaile.errors.empty?
      redirect_to action: :index
    else
      prepare_ingredient_items
      render :edit
    end
  end

  def find_item
    @coctaile = Coctaile.where(id: params[:id]).first
  end

end
