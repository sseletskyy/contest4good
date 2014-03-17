# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contest do |f|
    committee_head = FactoryGirl.create(:committee_head)
    jury_head = FactoryGirl.create(:jury_head)
    f.name "MyString"
    f.starts_at "2014-03-10 04:44:09"
    f.ends_at "2014-03-10 04:44:09"
    f.regulations "MyText"
    f.committee_head_ids [committee_head.id]
    f.jury_head_ids [jury_head.id]
  end
end