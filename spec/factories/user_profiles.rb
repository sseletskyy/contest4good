# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile, :class => 'UserProfile' do
    user nil
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    born_on "1998-01-02"
    address { Faker::Address.street_address }
    school { Faker::Number.number(2) }
    grade "9Б"
    phone { Faker::Number.number(7) }
    parent_name { Faker::Name.name }
    parent_phone { Faker::Number.number(7) }
    terms true
  end
end
