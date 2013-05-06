class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.string :name
      t.integer :lower_limit
      t.integer :upper_limmit
      t.integer :competition_id

      t.timestamps
    end
  end
end
