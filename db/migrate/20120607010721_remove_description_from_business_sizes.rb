class RemoveDescriptionFromBusinessSizes < ActiveRecord::Migration
  def up
    remove_column :business_sizes, :description
  end

  def down
    add_column :business_sizes, :description, :string
  end
end
