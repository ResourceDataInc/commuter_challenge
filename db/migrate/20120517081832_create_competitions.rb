class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :title
      t.date :start
      t.date :end
      t.text :description

      t.timestamps
    end
  end
end
