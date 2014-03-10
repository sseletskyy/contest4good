# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email "vali.d_admin@email.com"
    password "Abc123"
    password_confirmation "Abc123"
    admin_profile
    confirmed_at {Time.zone.now}
  end
end
