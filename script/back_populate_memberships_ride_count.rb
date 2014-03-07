require_relative "../config/environment"

competition = Competition.first

weeks = (competition.start_on..competition.end_on).map do |date|
  date.beginning_of_week..date.end_of_week
end.to_a.uniq

User.joins(:memberships).includes(:memberships, :rides).find_each do |user|
  membership = user.memberships.first
  membership.ride_count = 0

  weeks.each do |week|
    rides = user.rides.work_trips.where(date: week)
    score_counter = WeeklyScoreCalculator.new(week.first)
    score = score_counter.score(rides)
    membership.ride_count += score
  end

  membership.save
  print "."
end

puts
