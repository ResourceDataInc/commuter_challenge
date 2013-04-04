FactoryGirl.define do
  factory :user do
    email "test@example.com"
    username "testuser"
    password "pwd4test"
    password_confirmation { password }
  end
end
