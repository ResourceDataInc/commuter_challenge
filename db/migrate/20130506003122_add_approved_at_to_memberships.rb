class AddApprovedAtToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :approved_at, :datetime
  end
end
