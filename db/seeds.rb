def create_user!(username)
  User.create!(email: "#{username}@example.com",
               username: username,
               password: "password",
               password_confirmation: "password")
end

def log_rides!(member)
  score_keeper = ScoreKeeper.new(member)

  (1..14).each do |i|
    ride = Ride.new(rider: member,
                    date: i.days.ago,
                    bike_distance: rand(1..10),
                    bus_distance: rand(0..10),
                    walk_distance: rand(0..2),
                    description: "#{member.username} Ride #{i}",
                    work_trip: [true, false].sample,
                    type: Ride.types.values.sample)

    score_keeper.update(ride) { ride.save! }
  end
end

owner = create_user!("owner")

competition = Competition.create!(title: "Awesome Comp",
                                  description: "Awesomest competition evar!",
                                  start_on: 2.weeks.ago,
                                  end_on: 3.months.from_now,
                                  owner: owner)

small_bracket = Bracket.create!(name: "Small", competition: competition,
                                lower_limit: 1,
                                upper_limit: 10)

medium_bracket = Bracket.create!(name: "Medium", competition: competition,
                                 lower_limit: 11,
                                 upper_limit: 25)

Bracket.find_each do |bracket|
  %w{red blue}.each do |color|
    captain = create_user!("#{bracket.name}-#{color}-captain".downcase)

    team = Team.create!(name: "#{bracket.name} #{color} Team".titleize,
                       description: color,
                       business_size: rand(bracket.lower_limit..bracket.upper_limit),
                       captain: captain)

    Membership.create!(user: captain, team: team, approved: true)

    Competitor.create!(team: team, competition: competition, approved: true)

    log_rides!(captain)

    (team.business_size - 1).times do |i|
      member = User.create!(email: "#{bracket.name}-#{color}-member#{i+1}@example.com".downcase,
                            username: "#{bracket.name}-#{color}-member#{i+1}".downcase,
                            password: "password",
                            password_confirmation: "password")

      Membership.create!(user: member, team: team, approved: true)

      log_rides!(member)
    end
  end
end
