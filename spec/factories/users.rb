FactoryGirl.define do
  factory :user do
    email
    username { email.split("@").first }
    password "pwd4test"
    password_confirmation { password }
  end
end
