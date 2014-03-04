# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile, :class => 'UserProfile' do
    user nil
    first_name "MyString"
    middle_name "MyString"
    last_name "MyString"
    born_on "2014-03-04"
    address "MyString"
    school "MyString"
    grade "MyString"
    phone "MyString"
    parent_name "MyString"
    parent_phone "MyString"
  end
end
