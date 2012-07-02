class AddApprovedToCompetitionsTeam < ActiveRecord::Migration
  def change
    add_column :competitions_teams, :approved, :boolean, :default => false
  end
end
