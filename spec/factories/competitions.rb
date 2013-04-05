FactoryGirl.define do
  factory :competition do
    title "Awesome Competition"
    description "This competition is so awesome"
    start_on "2013-04-05"
    end_on "2013-04-05"
    owner factory: :user
  end
end
