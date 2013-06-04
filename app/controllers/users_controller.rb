class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @rides = @user.rides.latest
  end
end
