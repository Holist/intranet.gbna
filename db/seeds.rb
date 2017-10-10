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
  email: 'g.rauber@bordeauxnord.com',
  first_name: 'Grégory',
  last_name: 'Rauber',
  password: '123456',
  username: 'grauber',
  ldap_imported: true
)

User.create(
  email: 'admin@bordeauxnord.com',
  first_name: 'Admin',
  password: '123456',
  username: 'admin',
  ldap_imported: false
)

User.create(
  email: 'toto@gmail.com',
  first_name: 'To',
  last_name: 'To',
  password: '123456',
  username: 'toto',
  ldap_imported: false
)













puts "Choogles creation"

1.upto(30) do |n|
    Choogle.create!(
      slug: SecureRandom.urlsafe_base64(5),
      title: Faker::Superhero.name,
      due_at: "Mon, #{rand(1..15)} Oct 2017 21:20:44 UTC +00:00",
      happens_at: "Mon, #{rand(16..31)} Oct 2017 21:20:44 UTC +00:00",
      user: User.all.sample,
    )
end

puts "Comments creation"

1.upto(50) do |n|
    Comment.create!(
      content: Faker::Lorem.sentence,
      user: User.all.sample,
      choogle: Choogle.all.sample,
    )
end

puts "Places creation"

# Method to fill api_google_id of places table from google API
# Authenticate with google api key
# Query info from address and keep the first result
# Take .place_id method from google to fill our DB

def google_id(address)
  @client = GooglePlaces::Client.new(ENV['GOOGLE_API_SERVER_KEY'])
  place_info = @client.spots_by_query(address)[0]
  place_info.nil? ? "not find" : place_info.place_id
end

1.upto(15) do |n|
  country = Faker::Address.country
    Place.create!(
      address: country,
      name: Faker::Company.name,
      api_google_id: google_id(country),
    )
end

puts "Proposals creation"

1.upto(120) do |n|
    Proposal.create!(
      choogle: Choogle.all.sample,
      place: Place.all.sample,
      user: User.all.sample,
    )
end

puts "Upvotes creation"

1.upto(150) do |n|

  upvotes = [Proposal.all.sample, User.all.sample]
  # To match the validation (uniqueness of user and proposal) before creating
  # an upvotes we check if .where return something, if not the values are good
  # if true new values are genereate and finally an upvote can be created.
  while Upvote.where(proposal: upvotes[0], user: upvotes[1]).size != 0
    upvotes = [Proposal.all.sample, User.all.sample]
  end

    Upvote.create!(
      proposal: upvotes[0],
      user: upvotes[1],
    )
end

puts "Notifications creation"

1.upto(8) do |n|
    Notification.create!(
      choogle: Choogle.all.sample,
      user: User.all.sample,
    )
end

puts "Tags creation"

1.upto(100) do |n|
    Tag.create!(
      name: Faker::Lorem.word + Faker::Number.number(2),
      color: Faker::Color.hex_color,
    )
end

puts "Proposal_Tags creation"

1.upto(60) do |n|
    ProposalTag.create!(
      proposal: Proposal.all.sample,
      tag: Tag.all.sample,
    )
end

puts "Well done myself ! - HAL"
