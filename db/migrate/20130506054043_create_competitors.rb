class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.references :competition
      t.references :team
      t.boolean :approved
      t.datetime :approved_at

      t.timestamps
    end
    add_index :competitors, :competition_id
    add_index :competitors, :team_id
  end
end
