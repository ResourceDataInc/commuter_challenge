class CompetitionsTeams < ActiveRecord::Migration
  def change
    create_table :competitions_teams do |t|
      t.references :competition
      t.references :team
    end
    
    add_index :competitions_teams, :competition_id
    add_index :competitions_teams, :team_id
  end
end
