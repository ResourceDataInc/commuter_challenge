class AddMembershipsCountToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :memberships_count, :integer, :default=>0
    Team.find_each do |team|
      Team.reset_counters(team.id, :memberships)
    end
  end
end
