puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Becky', :email => 'becky.sue.boone@gmail.com', :password => 'norain', :password_confirmation => 'norain'
puts 'New user created: ' << user.name
user.add_role :admin

puts "SETTING UP DEFAULT COMPETITION"
competition = Competition.create! name: "Summer Bike Challenge", description: "Friendly competition to encourage bicycle commuting and see which businesses can get the greatest percentage of employees commuting to work by bike.", start_date: Date.parse("21/05/2012"), end_date: Date.parse("17/08/2012"), contact: user
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
