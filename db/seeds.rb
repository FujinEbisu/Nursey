# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Feed.destroy_all
Mother.destroy_all
Doctor.destroy_all
User.destroy_all
Child.destroy_all
Message.destroy_all
puts "db destroyed"

10.times do
  Mother.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 40)
  )
  Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    speciality: Faker::Job.field,
    availability: Faker::Time.forward(days: 23, period: :morning)
  )
    User.create!(
      email: Faker::Internet.email,
      password: "azerty",
      password_confirmation: "azerty",
      userable_type: ['Mother', 'Doctor'].sample,
      userable_id: (Mother.last.id)
    )
    User.create!(
      email: Faker::Internet.email,
      password: "azerty",
      password_confirmation: "azerty",
      userable_type: ['Mother', 'Doctor'].sample,
      userable_id: (Doctor.last.id)
    )

  Child.create!(
    first_name: Faker::Name.first_name,
    mother_id: Mother.last.id
  )
  Feed.create!(
    nursy_type: ['Tirage', 'Tétée'].sample,
    mother_id: Mother.last.id,
    child_id: Child.last.id,
    quantity_left: Faker::Number.decimal(l_digits: 1, r_digits: 2),
    quantity_right: Faker::Number.decimal(l_digits: 1, r_digits: 2),
    time_left: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
    time_right: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
    mood: rand(1..5),
    comment: Faker::Lorem.sentence(word_count: 10)
  )
  Message.create!(
    content: Faker::Lorem.sentence(word_count: 10),
    mother_id: Mother.last.id,
    doctor_id: Doctor.last.id
  )
  puts "Created Mother, Doctor, Children and User records and a few messages."
end
puts "10 Mothers, Doctors, Children, Users, Messages created successfully."
