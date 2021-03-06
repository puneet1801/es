# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# list = List.pluck(:id)
# (1..100000).each do |i|
# 	Contact.create(name: Faker::Name.name, email: Faker::Internet.free_email, domain: Faker::Internet.domain_name, address: Faker::Address.street_address, city: Faker::Address.city, list_id: list.sample)
# end

(1..10).each do |i|
	Campaign.create(name: "campaign#{i}", campaign_type: Campaign::CampaignType.sample)
end

(1..500).each do |i|
	Campaign.all.sample.lists.create(name: "list#{i}", list_type: List::ListType.sample)
end

(2_86_621..4_000_000).each do |i|
	List.all.sample.contacts.create(name: Faker::Name.name, email: Faker::Internet.free_email, domain: Faker::Internet.domain_name, address: Faker::Address.street_address, city: Faker::Address.city)
end