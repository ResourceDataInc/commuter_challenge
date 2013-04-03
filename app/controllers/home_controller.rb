class HomeController < ApplicationController
  def index
    flash[:success] = "Success!"
    flash[:error] = "Error!"
    flash[:warning] = "Warning!"
    flash[:info] = "Info!"
  end
end
