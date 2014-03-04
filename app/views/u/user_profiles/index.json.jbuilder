json.array!(@user_profiles) do |user_profile|
  json.extract! user_profile, :id, :user_id, :first_name, :middle_name, :last_name, :born_on, :address, :school, :grade, :phone, :parent_name, :parent_phone
  json.url user_profile_url(user_profile, format: :json)
end
