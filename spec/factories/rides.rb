# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ride do
    date "2013-05-02"
    distance "9.99"
    description "MyText"
    rider factory: :user
    is_round_trip false
  end
end
