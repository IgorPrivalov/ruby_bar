class Admin::WelcomeController < Admin::ApplicationController

  before_filter :authenticate_admin!

  def show
    
  end

end