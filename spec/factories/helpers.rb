FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end
end
