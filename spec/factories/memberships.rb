FactoryGirl.define do
  factory :membership do
    team
    user
    approved true
  end
end
