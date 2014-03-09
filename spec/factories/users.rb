# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "vali.d@email.com"
    password "Abc123"
    password_confirmation "Abc123"
    user_profile
    confirmed_at {Time.zone.now}
  end
end
