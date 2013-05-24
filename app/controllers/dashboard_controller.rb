include Warden::Test::Helpers
class DashboardController < ApplicationController
  #authorize_resource :class => false

  def index
    login_as User.find(4)
    @ride = current_user.rides.first
    @ride.date = Date.today
    @ride.is_round_trip = true
  end
end
