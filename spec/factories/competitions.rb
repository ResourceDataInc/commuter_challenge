# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :competition do
    name "MyString"
    description "MyText"
    start_date "2012-06-05"
    end_date "2012-06-05"
    contact_id nil
  end
end
