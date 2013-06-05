class DashboardController < ApplicationController
  authorize_resource :class => false

  def index
    @rides = current_user.rides.latest.first(16)
    @ride = build_ride
  end

  private

  def build_ride
    last_ride = current_user.rides.latest.work_trips.first
    if last_ride.present?
      attrs = last_ride.attributes.slice(*copyable_ride_attrs)
    else
      attrs = {}
    end
    Ride.new(default_ride_attrs.merge(attrs).symbolize_keys)
  end

  def copyable_ride_attrs
    %w{bike_distance bus_distance walk_distance description is_round_trip work_trip}
  end

  def default_ride_attrs
    { date: Calendar.today, is_round_trip: true, work_trip: true }
  end
end
