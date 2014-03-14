puts 'ROLES'

unless Rails.env.production?
  Admin.destroy_all

  Role.destroy_all
end

Contest4good::create_roles

puts "DEFAULT ADMIN USER"
admin_data = {
    email: ENV['ADMIN_EMAIL'].dup,
    password: ENV['ADMIN_PASSWORD'].dup
}
admin = Admin.where(email: admin_data[:email]).first_or_create(admin_data)
admin.password_confirmation = admin.password
admin.build_admin_profile({
                              first_name: ENV['ADMIN_FIRST_NAME'].dup,
                              middle_name: ENV['ADMIN_FIRST_NAME'].dup,
                              last_name: ENV['ADMIN_LAST_NAME'].dup,
                              phone: '0675803213'})
admin.save!
admin.accept_invitation!
admin.add_role :admin

puts 'admin: ' << "#{admin.admin_profile.first_name} #{admin.admin_profile.last_name}"
puts admin.email
puts admin.password

unless Rails.env.production?
  5.times do
    admin = fg.create(:admin)
    admin.accept_invitation!
    puts 'admin: ' << "#{admin.admin_profile.first_name} #{admin.admin_profile.last_name}"
    puts admin.email
    puts admin.password

  end

end
