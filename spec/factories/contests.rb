# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contest do
    name "MyString"
    starts_at "2014-03-10 04:44:09"
    ends_at "2014-03-10 04:44:09"
    regulations "MyText"
    committee_head_ids { [FactoryGirl.create(:committee_head).id] }
    jury_head_ids { [FactoryGirl.create(:jury_head).id] }
  end
end