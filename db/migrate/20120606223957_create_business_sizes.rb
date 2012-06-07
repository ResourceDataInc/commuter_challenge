class CreateBusinessSizes < ActiveRecord::Migration
  def change
    create_table :business_sizes do |t|
      t.string :name
      t.text :description
      t.integer :lower_bound
      t.integer :upper_bound
      t.references :competition

      t.timestamps
    end
    
    add_index :business_sizes, :competition_id
  end
end
