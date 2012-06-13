puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Becky', :email => 'becky.sue.boone@gmail.com', :password => 'norain', :password_confirmation => 'norain'
puts 'New user created: ' << user.name
user.add_role :admin

puts "SETTING UP DEFAULT COMPETITION"
competition = Competition.create! name: "2012 BCA Summer Bike Challenge", 
description: "Join the Alaska chapter of the American Institute of Architects and Bicycle Commuters of Anchorage in a friendly competition to encourage bicycle commuting and see which businesses can get the greatest percentage of employees commuting to work by bike. Join in at any time throughout the summer. There will be an awards party and celebration (location and date TBD). Last year we had great door prizes and of course some fantastic trophies for the winners. We welcome sponsors and prize donors.  Let us know if you would like to contribute to this celebration of people power.  See http://bicycleanchorage.org/wordpress/?page_id=2038 for additional information.", start_date: Date.parse("21/05/2012"), end_date: Date.parse("17/08/2012"), contact: user
puts "New competition created " + competition.name

puts "SETTING UP DEFAULT BUSINESS SIZES"
small = competition.business_sizes.create! name: 'Small', lower_bound: 1, upper_bound: 15
puts "New business size created: " + small.name
medium = competition.business_sizes.create! name: 'Medium', lower_bound: 16, upper_bound: 50
puts "New business size created: " + medium.name
large = competition.business_sizes.create! name: 'Large', lower_bound: 51, upper_bound: 200
puts "New business size created: " + large.name
xlarge = competition.business_sizes.create! name: 'X-Large', lower_bound: 201
puts "New business size created: " + xlarge.name

puts "SETTING UP DEFAULT TEAMS"
rdi = Team.create! name: "RDI Riders", description: "Riders from Resource Data, Inc", user_id: user.id, business_size: 81
puts "New team created: " + rdi.name

puts "SETTING UP DEFAULT TEAMS ON COMPETITIONS"
rdi.competitions << competition
rdi.save
puts "Added " + rdi.name + " to " + competition.name

puts "SETTING UP DEFAULT USERS ON TEAMS"
user.teams << rdi
user.save
puts "Added " + user.name + " to " + rdi.name

puts "SETTING UP DEFAULT RIDES"
ride = Ride.create! name: 'Test Ride', date: Time.now, user: user, distance: 1.2
puts "Added a ride for " + user.name + " for " + ride.distance.to_s + " miles"

