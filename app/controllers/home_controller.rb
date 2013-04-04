class HomeController < ApplicationController
  def index
  end

  def secret
    authorize! :read, :secret
  end
end
