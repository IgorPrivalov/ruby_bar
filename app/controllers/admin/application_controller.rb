class Admin::ApplicationController < ApplicationController

  before_filter :authenticate_admin!

  layout "admin_application"
end