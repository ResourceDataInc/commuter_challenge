class DashboardController < ApplicationController
  authorize_resource :class => false

  def index
    @rides = current_user.rides.first(9)
    @ride = build_ride
  end

  private

  def build_ride
    if current_user.rides.any?
      last_ride = current_user.rides.first
      attrs = last_ride.attributes.slice(*%w{distance description is_round_trip})
    else
      attrs = {}
    end
    Ride.new(attrs.merge(date: Date.today))
  end
end
