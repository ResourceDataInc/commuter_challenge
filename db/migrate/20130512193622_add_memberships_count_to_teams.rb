class AddMembershipsCountToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :memberships_count, :integer, :default=>0
    Team.find_each do |team|
      team.update_attribute(:memberships_count, team.memberships.length)
      team.save
    end
  end
end
