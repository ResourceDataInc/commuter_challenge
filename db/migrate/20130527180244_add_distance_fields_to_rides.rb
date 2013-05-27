class AddDistanceFieldsToRides < ActiveRecord::Migration
  def change
    rename_column :rides, :distance, :bike_distance
    add_column :rides, :bus_distance, :decimal
    add_column :rides, :walk_distance, :decimal
  end
end
