owner = User.where(email: "owner@example.com").first_or_create!(
  username: "owner",
  password: "password",
  password_confirmation: "password")

competition = Competition.where(title: "Awesome Comp").first_or_create!(
  description: "Awesomest competition evar!",
  start_on: Time.now,
  end_on: 3.months.from_now,
  owner_id: owner.id)

small_bracket = Bracket.where(name: "Small", competition_id: competition.id).first_or_create!(
  lower_limit: 1,
  upper_limit: 10)

medium_bracket = Bracket.where(name: "Medium", competition_id: competition.id).first_or_create!(
  lower_limit: 11,
  upper_limit: 25)

captain1 = owner
team1 = Team.where(name: "Team 1").first_or_create!(
  description: "Team 1",
  business_size: 5,
  captain_id: captain1.id)
Membership.where(user_id: captain1.id, team_id: team1.id).first_or_create!(
  approved: true)

team1mate1 = User.where(email: "team1mate1@example.com").first_or_create!(
  username: "team1mate1",
  password: "password",
  password_confirmation: "password")
Membership.where(user_id: team1mate1.id, team_id: team1.id).first_or_create!(
  approved: true)

team1mate2 = User.where(email: "team1mate2@example.com").first_or_create!(
  username: "team1mate2",
  password: "password",
  password_confirmation: "password")
Membership.where(user_id: team1mate2.id, team_id: team1.id).first_or_create!(
  approved: true)


team1mate3 = User.where(email: "team1mate3@example.com").first_or_create!(
  username: "team1mate3",
  password: "password",
  password_confirmation: "password")
Membership.where(user_id: team1mate3.id, team_id: team1.id).first_or_create!(
  approved: false)

captain2 = User.where(email: "captain2@example.com").first_or_create!(
  username: "captain2",
  password: "password",
  password: "password")
team2 = Team.where(name: "Team 2").first_or_create!(
  description: "Team 2",
  business_size: 7,
  captain_id: captain2.id)
Membership.where(user_id: captain2.id, team_id: team2.id).first_or_create!(
  approved: true)

team2mate1 = User.where(email: "team2mate1@example.com").first_or_create!(
  username: "team2mate1",
  password: "password",
  password_confirmation: "password")
Membership.where(user_id: team2mate1.id, team_id: team2.id).first_or_create!(
  approved: true)

team2mate2 = User.where(email: "team2mate2@example.com").first_or_create!(
  username: "team2mate2",
  password: "password",
  password_confirmation: "password")

Membership.where(user_id: team2mate2.id, team_id: team2.id).first_or_create!(
  approved: true)

Competitor.where(team_id: team1.id, competition_id: competition.id).first_or_create!(approved: true)
Competitor.where(team_id: team2.id, competition_id: competition.id).first_or_create!(approved: true)

(1..20).each do |i| 
  Ride.create!(
    rider_id: team1mate3.id,
    date: i.day.ago,
    bike_distance: rand(1..10),
    bus_distance: rand(0..10),
    walk_distance: rand(0..2),
    description: i)
end
