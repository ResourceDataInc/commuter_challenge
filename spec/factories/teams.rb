FactoryGirl.define do
  factory :team do
    name "Test Name"
    description "Test Description"
    captain factory: :user
  end
end
