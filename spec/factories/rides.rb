# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ride do
    date Date.today
    bike_distance 9001
    description "Epic Ride"
    rider factory: :user
    is_round_trip false
    work_trip true
  end
end
