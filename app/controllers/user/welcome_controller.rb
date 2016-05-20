class User::WelcomeController < User::ApplicationController

  before_filter :authenticate_user!

  def index
    @shorts = []
    @longs = []
    @coctailes = Coctaile.includes(:ingredients, :products)
    @coctailes.each do |coctaile|
      if coctaile.have_alc
        if coctaile.value <= 100
          @shorts.push coctaile
        else
          @longs.push coctaile
        end
      end
    end
  end

  def show
    @coctailes = Coctaile.where(name: params[:name])
  end

end