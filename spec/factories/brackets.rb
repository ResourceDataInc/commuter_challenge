# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bracket do
    name "MyString"
    lower_limit 1
    upper_limit 100
    competition factory: :competition
  end
end
