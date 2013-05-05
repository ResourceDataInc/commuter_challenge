class AddRiderIdToRides < ActiveRecord::Migration
  def change
    add_column :rides, :rider_id, :integer
  end
end
