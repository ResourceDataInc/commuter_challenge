namespace :scores do
  desc "Recalculate scores for current competition"
  task :recalculate => ["environment"] do
    competition = Competition.by_start_date.first

    unless competition.present? && competition.active?
      puts "No active competition. Exiting..."
      exit
    end

    date_range = competition.start_on..Calendar.today
    week_start_days = date_range.map(&:beginning_of_week).uniq

    competition.memberships.approved.find_each do |membership|
      weekly_scores = week_start_days.map do |week_start_day|
        calculator = WeeklyScoreCalculator.new(week_start_day)
        week_trips = membership.rides.work_trips.where(date: calculator.date_range)
        calculator.score(week_trips)
      end

      membership.update_attributes(ride_count: weekly_scores.sum)
    end
  end
end
