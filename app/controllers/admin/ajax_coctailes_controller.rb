class Admin::AjaxCoctailesController < ApplicationController

  INGREDIENT_MAX_COUNT = 5

  before_filter :find_item, only: [:edit, :update, :destroy, :show, :show_hide]

  def index
    @coctailes = Coctaile.all
    @coctaile = Coctaile.new
  end

  def show
    respond_to do |format|
      if @coctaile
        format.html { redirect_to admin_ajax_coctailes_path @coctaile}
        format.js
        format.json { render json: @coctaile, status: :ok, location: @coctaile}
      else
        format.html { redirect_to admin_ajax_coctailes_path @coctaile }
        format.json { render json: @coctaile.errors, status: :not_found }
      end

    end
  end

  def edit
    respond_to do |format|
      if @coctaile
        format.html { redirect_to @coctaile, action: :show, notice: "Product was success" }
        format.js
        format.json { render json: @coctaile, status: :ok, location: @coctaile }
      else
        format.html { render action: :edit }
        format.json { render json: @coctaile.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @coctaile = Coctaile.new
  end

  def update
    respond_to do |format|
      if @coctaile.update_attributes(item_params)
        format.html { redirect_to admin_ajax_coctaile_path(@coctaile), notice: 'Product was success' }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @coctaile.errors, status: :unprocessable_entity }
      end
    end  
  end

  def show_hide
    puts "params: #{params}"
    puts "coctaile: #{@coctaile}"
    @coctaile.show_hide
    respond_to do |format|
      if @coctaile
        format.html { redirect_to @coctaile, action: :show }
        format.js
        format.json { render json: @coctaile, status: :ok, location: @coctaile }
      else
        format.html { render action: :show_hide }
        format.json { render json: @coctaile.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @coctaile = Coctaile.new item_params
    respond_to do |format|
      if @coctaile.save
        format.html { redirect_to @coctaile, notice: "Coctaile was created" }
        format.js
        format.json { render json: @coctaile, status: :created, location: @coctaile }
      else
        format.html { render action: :new}
        format.json { render json: @coctaile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @coctaile.destroy
    respond_to do |format|
      if @coctaile.errors.empty?
        format.html { redirect_to @coctaile, notice: 'Product was successfully removed.' }
        format.js {}
        format.json { render json: @coctaile, status: :ok, location: @coctaile }
      else
        format.html { render action: :index }
        format.json { render json: @coctaile.errors, status: :unprocessable_entity}
      end
    end

  end


  def prepare_ingredient_items
    (INGREDIENT_MAX_COUNT - @coctaile.ingredients.count).times{
      @coctaile.ingredients.build
    }
  end

  def item_params
    params.require(:coctaile).permit(:id, :name, :image, :value, :hiden, ingredients_attributes: [:id, :value, :product_id, :coctaile_id])
  end

  def find_item
    @coctaile = Coctaile.where(id: params[:id]).first
  end

end
