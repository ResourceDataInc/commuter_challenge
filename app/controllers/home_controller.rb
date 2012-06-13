class HomeController < ApplicationController
  def index
    redirect_to Competition.first
  end
end
