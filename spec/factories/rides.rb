# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ride do
    date Date.today
    distance 9001
    description "Epic Ride"
    rider factory: :user
    is_round_trip false
  end
end
