# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email { Faker::Internet.email }
    password "Abc123"
    password_confirmation "Abc123"
    admin_profile
    confirmed_at { Time.zone.now }
    role_ids [1]
  end

  factory :committee_head, class: Admin do
    email { Faker::Internet.email }
    password "Abc123"
    password_confirmation "Abc123"
    admin_profile
    confirmed_at { Time.zone.now }
  end

  factory :jury_head, class: Admin do
    email { Faker::Internet.email }
    password "Abc123"
    password_confirmation "Abc123"
    admin_profile
    confirmed_at { Time.zone.now }
  end
end
