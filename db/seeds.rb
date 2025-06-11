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

# Delete in correct order to avoid foreign key violations
Review.destroy_all      # Reviews reference SafePlaces and Mothers
Message.destroy_all     # Messages reference Doctors, Mothers, and Chats
Chat.destroy_all        # Chats reference Doctors and Mothers
Feed.destroy_all        # Feeds reference Mothers and Children
Child.destroy_all       # Children reference Mothers
Doctor.destroy_all      # Now safe to delete
Mother.destroy_all      # Now safe to delete (but we recreate them anyway)
SafePlace.destroy_all   # Now safe to delete
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
    speciality: Faker::Job.field
  )
    User.create!(
      email: Faker::Internet.email,
      password: "azerty",
      password_confirmation: "azerty",
      userable_type: 'Mother',
      userable_id: (Mother.last.id)
    )
    User.create!(
      email: Faker::Internet.email,
      password: "azerty",
      password_confirmation: "azerty",
      userable_type: 'Doctor',
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
  
  Chat.create!(
    mother_id: Mother.last.id,
    doctor_id: Doctor.last.id,
    status: "ouvert"
  )
  
  Message.create!(
    content: Faker::Lorem.sentence(word_count: 10),
    mother_id: Mother.last.id,
    doctor_id: Doctor.last.id,
    chat_id: Chat.last.id,
    sender: ["Mother", "Doctor"].sample
  )

  puts "Created Mother, Doctor, Children and User records and a few messages."
end

# --- AJOUT : 15 restaurants girondins comme SafePlace ---
safe_places_attributes = [
  { name: "La Brasserie Bordelaise",   adress: "50 Rue Saint-Rémi, 33000 Bordeaux",                 latitude: 44.8423, longitude: -0.5740 },
  { name: "Le Petit Commerce",         adress: "22 Rue Parlement Saint-Pierre, 33000 Bordeaux",     latitude: 44.8413, longitude: -0.5717 },
  { name: "L'Entrecôte",               adress: "4 Cours du 30 Juillet, 33000 Bordeaux",            latitude: 44.8423, longitude: -0.5720 },
  { name: "Chez Pompon",               adress: "8 Rue Huguerie, 33000 Bordeaux",                    latitude: 44.8430, longitude: -0.5800 },
  { name: "Miles",                     adress: "33 Rue du Cancera, 33000 Bordeaux",                 latitude: 44.8407, longitude: -0.5705 },
  { name: "La Tupina",                 adress: "6 Rue Porte de la Monnaie, 33800 Bordeaux",         latitude: 44.8338, longitude: -0.5663 },
  { name: "Symbiose",                  adress: "4 Quai des Chartrons, 33000 Bordeaux",              latitude: 44.8453, longitude: -0.5688 },
  { name: "Ragazzi da Peppone",        adress: "12 Rue Georges Bonnac, 33000 Bordeaux",             latitude: 44.8425, longitude: -0.5771 },
  { name: "Restaurant Mélodie",        adress: "5 Allées de Tourny, 33000 Bordeaux",                latitude: 44.8438, longitude: -0.5725 },
  { name: "Garopapilles",              adress: "62 Rue Abbé de l'Épée, 33000 Bordeaux",             latitude: 44.8450, longitude: -0.5764 },
  { name: "Le Seven",                  adress: "7 Quai de la Monnaie, 33800 Bordeaux",              latitude: 44.8354, longitude: -0.5677 },
  { name: "Le Bistrot des Frangins",   adress: "36 Cours Portal, 33000 Bordeaux",                   latitude: 44.8482, longitude: -0.5670 },
  { name: "Le Chapon Fin",             adress: "5 Rue Montesquieu, 33000 Bordeaux",                 latitude: 44.8434, longitude: -0.5743 },
  { name: "Le Pressoir d'Argent",      adress: "2-5 Place de la Comédie, 33000 Bordeaux",           latitude: 44.8425, longitude: -0.5758 },
  { name: "Le Siman",                  adress: "7 Quai des Queyries, 33100 Bordeaux",               latitude: 44.8414, longitude: -0.5539 }
]

safe_places_attributes.each do |attrs|
  SafePlace.create!(
    attrs.merge(
      options: ["Chaise haute", "Espace allaitement", "Espace change", "Espace jeux",
                "Espace biberons", "Espace sieste enfants", "Bière pour papa"].sample(3)
    )
  )
end

# Create reviews for safe places
SafePlace.all.each do |safe_place|
  # Create 2-5 reviews per safe place
  rand(2..5).times do
    Review.create!(
      comment: Faker::Restaurant.review,
      rating: [3.5, 4.0, 4.5, 5.0, 2.5, 3.0].sample, # Mostly positive ratings
      safe_place_id: safe_place.id,
      mother_id: Mother.all.sample.id
    )
  end
end

puts "15 SafePlaces créés avec succès."
puts "Reviews created for all SafePlaces."
puts "10 Mothers, Doctors, Children, Users, Messages created successfully."
