class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :user

      t.timestamps
    end
    add_index :competitions, :user_id
  end
end
