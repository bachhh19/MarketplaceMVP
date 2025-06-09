require 'faker'

puts "Suppression des données existantes..."
Item.delete_all
Cart.delete_all
Product.delete_all
User.delete_all

puts "Création des utilisateurs..."

User.create!(
  email: "seller@gmail.com",
  password: "1234567",
  role: "seller",
  firstname: "Jean",
  lastname: "Dupont"
)

User.create!(
  email: "buyer@gmail.com",
  password: "1234567",
  role: "buyer",
  firstname: "John",
  lastname: "Doe"
)

puts "Création des produits..."

User.where(role: "seller").each do |seller|
  rand(2..5).times do
    Product.create!(
      user: seller,
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence(word_count: 10),
      price: Faker::Commerce.price(range: 10..100.0),
      image_url: Faker::LoremFlickr.image(size: "200x200", search_terms: ['product'])
    )
  end
end

puts "Seed terminé !"
