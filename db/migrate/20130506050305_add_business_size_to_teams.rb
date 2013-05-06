class AddBusinessSizeToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :business_size, :integer
  end
end
