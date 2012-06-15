def sanitize_attributes(attributes)
  attrs = attributes.dup
  [:password, :password_confirmation].each { |attr| attrs.delete attr }
  attrs
end

def find_or_create(klass, attributes = {})
  results = klass.where( sanitize_attributes(attributes)).first
  
  if results.present?
    puts "#{klass} exists, skipping"
  else
    results = klass.create! attributes 
    puts "Creating #{klass} with an id of " + results.id.to_s
  end
  results
end

# Users
user = find_or_create User, :name => 'Becky', :email => 'becky.sue.boone@gmail.com', :password => 'norain', :password_confirmation => 'norain'

# Competitions
competition = find_or_create Competition, name: "2012 BCA Summer Bike Challenges", 
  description: "Join the Alaska chapter of the American Institute of Architects and Bicycle Commuters of Anchorage in a friendly competition to encourage bicycle commuting and see which businesses can get the greatest percentage of employees commuting to work by bike.\n\n##What are the rules?\n1. **The businesses in each class with the highest _PERCENTAGE_ of total employee trips to/from work made by bike win.**   The goal of the challenge is to get more people to go by bike. So we focus on the percentage of employees in your business that are going to work each day by bike.  \n`total # of commute trips possible = # of employees X # days in challenge (5 days a week)`  \n`percent of participation = total # of actual commutes/total # of commute trips possible`  \nThe businesses in each class with the highest percentage of commutes by bike win.\n1. **You compete among businesses of similar size.**  The business classification is based on the total number of employees, not the number of employees in your office that may bike. This encourages team captains to get as many people in their business to bike (even if it is just one trip a week) as every trip helps increase the percentage of trips by bike.  \nYou can register a division, section, branch, etc. for this competition - it doesn't have to be the entire business (e.g. a section or department of a government agency or a branch of a business).  \n1. **Track your trips.**  Use this site to track your trips or track trips using an excel spreadsheet.  \n1.  **This competition is for businesses located in the Anchorage bowl.**  We know folks across the state want to participate but this is a challenge for Anchorage businesses.  \n1. **Register today.**  You can register by signing your team up on this site. Or by emailing [Brian Litmans](info@bicycleanchorage.org).  \nThe competition begins on Monday May 21st, 2012.  But you can join in at any time throughout the summer.  \nThere will be an awards party and celebration (location and date TBD). Last year we had great door prizes and of course some fantastic trophies for the winners.  \n\n##Award Recognition Categories  \n* Business winners for each category  \n* Most individual miles (first, second and third place)  \n* Most trips made (first, second and third place)  \n\nWe welcome sponsors and prize donors.  Let us know if you'd like to contribute to this celebration of people power.  Contact catherine@callbluesky.com to find out how you can contribute.   \n\nWatch for competition updates on BCA's [Facebook page](https://www.facebook.com/pages/Bicycle-Commuters-of-Anchorage/351000137165) and [website](http://bicycleanchorage.org).", 
  start_date: Date.parse("21/05/2012"), end_date: Date.parse("17/08/2012"), user_id: user.id

# Business Sizes
small = find_or_create BusinessSize, name: "Small", lower_bound: 1, upper_bound: 15, competition_id: competition.id
medium = find_or_create BusinessSize, name: "Medium", lower_bound: 16, upper_bound: 50, competition_id: competition.id
large = find_or_create BusinessSize, name: "Large", lower_bound: 51, upper_bound: 200, competition_id: competition.id
xlarge = find_or_create BusinessSize, name: "X-Large", lower_bound: 201, competition_id: competition.id

# Teams
rdi = find_or_create Team, name: "RDI Riders", description: "Riders from Resource Data, Inc", user_id: user.id, business_size: 81

# Add Team to Competition
teams_competitions = find_or_create CompetitionsTeam, :competition_id => competition.id, :team_id => rdi.id

# Add User to Team
users_teams = find_or_create TeamsUser, :team_id => rdi.id, :user_id => user.id

