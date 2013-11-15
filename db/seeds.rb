# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

demo_user = User.find_or_create_by_email("demo@demo.com")
if demo_user.new_record?
  demo_user.name    = "管理员"
  demo_user.password = "123456"
  demo_user.password_confirmation = "123456" 
  demo_user.save!
end
