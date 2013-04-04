class HomeController < ApplicationController
  before_filter :authenticate_user!, only: :secret

  def index
  end

  def secret
  end
end
