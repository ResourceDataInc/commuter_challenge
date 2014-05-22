class AddTypeToRides < ActiveRecord::Migration
  class Ride < ActiveRecord::Base
    self.inheritance_column = nil
    enum type: [:one_way, :round_trip]
  end

  def up
    add_column :rides, :type, :integer, default: 0

    Ride.where(is_round_trip: false).update_all(type: Ride.types[:one_way])
    Ride.where(is_round_trip: true).update_all(type: Ride.types[:round_trip])

    remove_column :rides, :is_round_trip
  end

  def down
    add_column :rides, :is_round_trip, :boolean

    Ride.one_way.update_all(is_round_trip: false)
    Ride.round_trip.update_all(is_round_trip: true)

    remove_column :rides, :type
  end
end
