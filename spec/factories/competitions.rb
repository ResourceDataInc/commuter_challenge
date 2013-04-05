FactoryGirl.define do
  factory :competition do
    title "Awesome Competition"
    description "This competition is so awesome"
    start_on { Time.now }
    end_on { 6.months.from_now }
    owner factory: :user
  end
end
