class AddRideCountToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :ride_count, :integer, default: 0
  end
end
