class AddDefaultValueToApprovedTeamsUser < ActiveRecord::Migration
  def change
    change_column :teams_users, :approved, :boolean, :default => false
  end
end
