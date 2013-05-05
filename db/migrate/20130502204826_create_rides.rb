class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.date :date
      t.decimal :distance
      t.text :description
      t.boolean :is_round_trip

      t.timestamps
    end
  end
end
