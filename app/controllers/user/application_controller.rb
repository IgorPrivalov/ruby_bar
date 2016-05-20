class User::ApplicationController < ApplicationController

  before_filter :authenticate_user!

  layout "user_application"
end