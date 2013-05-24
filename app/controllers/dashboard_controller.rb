class DashboardController < ApplicationController
  authorize_resource :class => false

  def index
    @ride = current_user.rides.first
    @ride.date = Date.today
    @ride.is_round_trip = true
    @rides = current_user.rides.first(9);
  end
end
