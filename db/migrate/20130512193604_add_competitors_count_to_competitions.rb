class AddCompetitorsCountToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :competitors_count, :integer, :default=>0
    Competition.find_each do |competition|
      Competition.reset_counters(competition.id, :competitors)
    end
  end
end
