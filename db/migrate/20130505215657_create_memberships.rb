class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :team_id
      t.integer :user_id
      t.boolean :approved, default: false

      t.timestamps
    end
    add_index :memberships, [:team_id, :user_id], unique: true
  end
end
