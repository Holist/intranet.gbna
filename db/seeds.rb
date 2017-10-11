# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Let's destroy all the tables datas."

UserOption.destroy_all
Option.destroy_all
User.destroy_all


puts "Let's generate a lot of useless things..."
puts "Like Users..."

User.create(
  email: 'r.neuville@bordeauxnord.com',
  first_name: 'Romain',
  last_name: 'Neuville',
  password: '123456',
  username: 'rneuville',
  ldap_imported: true
)

User.create(
  email: 'f.bonnet@bordeauxnord.com',
  first_name: 'Frédéric',
  last_name: 'Bonnet',
  password: '123456',
  username: 'fbonnet',
  ldap_imported: true
)

User.create(
  first_name: 'Grégory',
  last_name: 'Rauber',
  password: '123456',
  username: 'grauber',
  ldap_imported: true
)

User.create(
  first_name: 'Admin',
  password: '123456',
  username: 'admin',
)

User.create(
  email: 'toto@gmail.com',
  first_name: 'To',
  last_name: 'To',
  password: '123456',
  username: 'toto',
  ldap_imported: false
)

puts "Lets create some Options"


Option.create(
  name: 'MDP AD'
)

Option.create(
  name: 'MDP Lotus'
)

Option.create(
  name: 'MDP Sigems'
)

Option.create(
  name: 'MDP Youporn'
)

puts "Lets create some UserOptions"

# Some of theses will fail because of uniqueness validation, dont care.

1.upto(20) do |n|
  UserOption.create(
    user: User.all.sample,
    option: Option.all.sample,
    value: Faker::Internet.password(8)
  )
end

puts "Well done Skynet !"
