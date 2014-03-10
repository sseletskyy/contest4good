# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_profile do
    admin nil
    first_name "Иван"
    middle_name "Иваныч"
    last_name "Горбунков"
    phone "7332232"
  end
end
