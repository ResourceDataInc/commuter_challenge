puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Becky', :email => 'becky.sue.boone@gmail.com', :password => 'norain', :password_confirmation => 'norain'
puts 'New user created: ' << user.name
user.add_role :admin

puts "SETTING UP DEFAULT COMPETITION"
competition = Competition.create! name: "2012 BCA Summer Bike Challenge", 
description: "Join the Alaska chapter of the American Institute of Architects and Bicycle Commuters of Anchorage in a friendly competition to encourage bicycle commuting and see which businesses can get the greatest percentage of employees commuting to work by bike.\r\n\r\n##What are the rules?\r\n1. **The businesses in each class with the highest _PERCENTAGE_ of total employee trips to/from work made by bike win.**   The goal of the challenge is to get more people to go by bike. So we focus on the percentage of employees in your business that are going to work each day by bike.  \r\n`total # of commute trips possible = # of employees X # days in challenge (5 days a week)`  \r\n`percent of participation = total # of actual commutes/total # of commute trips possible`  \r\nThe businesses in each class with the highest percentage of commutes by bike win.\r\n1. **You compete among businesses of similar size.**  The business classification is based on the total number of employees, not the number of employees in your office that may bike. This encourages team captains to get as many people in their business to bike (even if it is just one trip a week) as every trip helps increase the percentage of trips by bike.  \r\nYou can register a division, section, branch, etc. for this competition – it doesn’t have to be the entire business (e.g. a section or department of a government agency or a branch of a business).  \r\n1. **Track your trips**  Use this site to track your trips or track trips using an excel spreadsheet.  \r\n1.  **This competition is for businesses located in the Anchorage bowl.**  We know folks across the state want to participate but this is a challenge for Anchorage businesses.  \r\n1. **Register today**  You can register by signing your team up on this site. Or by emailing [Brian Litmans](info@bicycleanchorage.org).  \r\nThe competition begins on Monday May 21st, 2012.  But you can join in at any time throughout the summer.  \r\nThere will be an awards party and celebration (location and date TBD). Last year we had great door prizes and of course some fantastic trophies for the winners.  \r\n\r\n##Award Recognition Categories  \r\n* Business winners for each category  \r\n* Most individual miles (first, second and third place)  \r\n* Most trips made (first, second and third place)  \r\n\r\nWe welcome sponsors and prize donors.  Let us know if you’d like to contribute to this celebration of people power.  Contact catherine@callbluesky.com to find out how you can contribute.   \r\n\r\nWatch for competition updates on BCA’s [Facebook page](https://www.facebook.com/pages/Bicycle-Commuters-of-Anchorage/351000137165) and [website](http://bicycleanchorage.org).", start_date: Date.parse("21/05/2012"), end_date: Date.parse("17/08/2012"), contact: user
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

