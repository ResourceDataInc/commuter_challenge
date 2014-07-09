FactoryGirl.define do
  factory :team do
    name "Test Name"
    description "Test Description"
    business_size 5
    captain factory: :user
  end
end




