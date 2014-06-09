# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ride do
    date Calendar.today
    bike_distance 9001
    description "Epic Ride"
    rider factory: :user
    type :one_way
    work_trip true
  end
end
