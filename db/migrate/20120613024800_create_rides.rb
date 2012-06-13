class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :name
      t.date :date
      t.decimal :distance
      t.references :user

      t.timestamps
    end
    add_index :rides, :user_id
  end
end
