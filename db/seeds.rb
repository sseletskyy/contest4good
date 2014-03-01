puts 'ROLES'
Contest4good::ROLES.each do |role|
  Role.where(name: role).first_or_create name: role
  puts 'Role: ' << role
end

puts "DEFAULT ADMIN USER"
user_data = {
  first_name: ENV['ADMIN_FIRST_NAME'].dup,
  last_name: ENV['ADMIN_LAST_NAME'].dup,
  email: ENV['ADMIN_EMAIL'].dup,
  password: ENV['ADMIN_PASSWORD'].dup
}
user = User.new(user_data)
user.password_confirmation = user.password
user.confirm!
user.activate!
user.add_role :admin

puts 'user: ' << "#{user.first_name} #{user.last_name}"
puts user.email
puts user.password
