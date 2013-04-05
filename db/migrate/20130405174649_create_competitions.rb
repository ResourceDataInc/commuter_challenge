class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :title
      t.text :description
      t.date :start_on
      t.date :end_on
      t.integer :owner_id

      t.timestamps
    end

    add_index :competitions, :owner_id
  end
end
