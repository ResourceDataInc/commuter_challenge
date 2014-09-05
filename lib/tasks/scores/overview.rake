namespace :scores do
  desc "Stats for the latest competition"
  task :overview => :environment do
    dev_null = Logger.new("/dev/null")
    Rails.logger = dev_null
    ActiveRecord::Base.logger = dev_null

    competition = Competition.last
    rides = competition.rides.where(date: competition.date_range)
    teams = competition.teams
    memberships = competition.memberships.approved

    top_bike = rides.group(:user_id).sum(:bike_distance).sort_by { |u, d| -d }.take(3).map { |u, d| [User.find(u), d] }
    top_bus = rides.group(:user_id).sum(:bus_distance).sort_by { |u, d| -d }.take(3).map { |u, d| [User.find(u), d] }
    top_walk = rides.group(:user_id).sum(:walk_distance).sort_by { |u, d| -d }.take(3).map { |u, d| [User.find(u), d] }

    total_bike = rides.sum(:bike_distance)
    total_bus = rides.sum(:bus_distance)
    total_walk = rides.sum(:walk_distance)
    total_distance = total_bike + total_bus + total_walk

    possible_trips = ParticipationCalculator.new(competition).member_possible_trips

    overachievers = memberships.where(ride_count: possible_trips).map { |m| m.user }.sort_by { |u| u.username }

    puts "Teams: #{teams.count}"
    puts "Participants: #{memberships.count}"

    puts "Top Bikers:"

    top_bike.each do |user, distance|
      puts "\t#{user.username} (#{user.teams.last.name}): #{distance} mi"
    end

    puts "Top Bussers:"

    top_bus.each do |user, distance|
      puts "\t#{user.username} (#{user.teams.last.name}): #{distance} mi"
    end

    puts "Top Walkers:"

    top_walk.each do |user, distance|
      puts "\t#{user.username} (#{user.teams.last.name}): #{distance} mi"
    end

    puts "Total Bike Distance: #{total_bike}"
    puts "Total Bus Distance: #{total_bus}"
    puts "Total Walk Distance: #{total_walk}"
    puts "Total Distance: #{total_distance}"

    puts "100% Commuters:"

    overachievers.each do |user|
      puts "\t#{user.username}"
    end
  end
end
