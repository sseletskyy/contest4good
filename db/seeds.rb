puts 'ROLES'
Contest4good::ROLES.each do |role|
  Role.where(name: role).first_or_create name: role
  puts 'Role: ' << role
end

puts "DEFAULT ADMIN USER"
admin_data = {
    email: ENV['ADMIN_EMAIL'].dup,
    password: ENV['ADMIN_PASSWORD'].dup
}
admin = Admin.new(admin_data)
admin.password_confirmation = admin.password
admin.build_admin_profile({
      first_name: ENV['ADMIN_FIRST_NAME'].dup,
      middle_name: ENV['ADMIN_FIRST_NAME'].dup,
      last_name: ENV['ADMIN_LAST_NAME'].dup,
      phone: '0675803213'})
admin.save!
admin.accept_invitation!
admin.add_role :admin

puts 'admin: ' << "#{admin.first_name} #{admin.last_name}"
puts admin.email
puts admin.password
