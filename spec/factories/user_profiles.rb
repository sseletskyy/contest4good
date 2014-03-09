# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile, :class => 'UserProfile' do
    user nil
    first_name "Вася"
    middle_name "Петевич"
    last_name "Путров"
    born_on "1998-01-02"
    address "Приморский 15"
    school "33"
    grade "9Б"
    phone "7332232"
    parent_name "Василиса Микулишна"
    parent_phone "101"
    terms true
  end
end
