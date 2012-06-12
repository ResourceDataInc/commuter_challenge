class TeamsUsers < ActiveRecord::Migration
  def change
    create_table :teams_users do |t|
      t.references :team
      t.references :user
    end
    
    add_index :teams_users, :team_id
    add_index :teams_users, :user_id
  end
end
