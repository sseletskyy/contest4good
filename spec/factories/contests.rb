# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contest do
    name "MyString"
    starts_at "2014-03-10 04:44:09"
    ends_at "2014-03-10 04:44:09"
    regulations "MyText"
  end
end
