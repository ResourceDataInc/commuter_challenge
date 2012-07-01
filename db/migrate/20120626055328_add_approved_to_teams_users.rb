class AddApprovedToTeamsUsers < ActiveRecord::Migration
  def change
    add_column :teams_users, :approved, :boolean
  end
end
