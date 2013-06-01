class AddWorkTripToRides < ActiveRecord::Migration
  def change
    add_column :rides, :work_trip, :boolean
  end
end
