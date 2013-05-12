class AddCompetitorsCountToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :competitors_count, :integer, :default=>0
    Competition.find_each do |competition|
      competition.update_attribute(:competitors_count, competition.competitors.length)
      competition.save
    end
  end
end
