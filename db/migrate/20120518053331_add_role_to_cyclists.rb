class AddRoleToCyclists < ActiveRecord::Migration
  def change
    add_column :cyclists, :role, :string

  end
end
