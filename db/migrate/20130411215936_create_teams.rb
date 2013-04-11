class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.integer :captain_id

      t.timestamps
    end

    add_index :teams, :captain_id
  end
end
