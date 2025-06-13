require 'faker'
require 'uri'

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
  email: "seller1@gmail.com",
  password: "1234567",
  role: "seller",
  firstname: "John",
  lastname: "Doe"
)

User.create!(
  email: "buyer@gmail.com",
  password: "1234567",
  role: "buyer",
  firstname: "John",
  lastname: "Doe"
)

puts "Création des produits..."

product_names = [
  "Lampe d’ambiance violette", "Tasse en céramique lavande", "Bougie parfumée lilas",
  "Carnet de notes mauve", "Écharpe en soie prune", "Coussin velours violet",
  "Vase en verre améthyste", "Tapis doux pour salon", "Diffuseur d’huiles essentielles",
  "Montre au bracelet violet", "Sac à main aubergine", "Bouteille d’eau réutilisable",
  "Casque audio violet", "Poster abstrait violet", "Plante artificielle violet",
  "Coque de téléphone lilas", "Baskets avec accents violets", "Chapeau en feutre prune"
]

User.where(role: "seller").each do |seller|
  rand(6..7).times do
    name = product_names.sample
    seed = URI.encode_www_form_component(name)

    image_url = "https://picsum.photos/seed/#{seed}/200/200"

    Product.create!(
      user: seller,
      name: name,
      description: Faker::Lorem.sentence(word_count: 12),
      price: Faker::Commerce.price(range: 10..20.0).round(2),
      image_url: image_url
    )
  end
end

puts "Seed terminé !"
