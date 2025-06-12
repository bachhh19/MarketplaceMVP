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

# User.where(role: "seller").each do |seller|
#   rand(2..5).times do
#     Product.create!(
#       user: seller,
#       name: Faker::Commerce.product_name,
#       description: Faker::Lorem.sentence(word_count: 10),
#       price: Faker::Commerce.price(range: 10..100.0),
#       image_url: Faker::LoremFlickr.image(size: "200x200", search_terms: ['product'])
#     )
#   end
# end

# dog_product_names = [
#   "Croquettes au bœuf", "Friandises au saumon", "Jouet en corde tressée",
#   "Panier moelleux", "Gamelle antidérapante", "Harnais rembourré", "Laisse extensible",
#   "Tapis de fouille", "Balle rebondissante", "Os en caoutchouc", "Pull en laine pour chien",
#   "Collier réfléchissant", "Distributeur de croquettes", "Brosse de toilettage",
#   "Dentifrice canin", "Shampooing hypoallergénique", "Sac de transport", "Gilet de sauvetage",
#   "Jouet distributeur", "Coupe-griffes ergonomique"
# ]

# User.where(role: "seller").each do |seller|
#   rand(30..40).times do
#     name = dog_product_names.sample
#     seed = URI.encode_www_form_component(name)
#     image_url = "https://picsum.photos/seed/#{seed}/200/200"
#     Product.create!(
#       user: seller,
#       name: name,
#       description: Faker::Lorem.sentence(word_count: 12),
#       price: Faker::Commerce.price(range: 10..100.0).round(2),
#       image_url: image_url
#     )
#   end
# end
product_names = [
  "Lampe d’ambiance violette", "Tasse en céramique lavande", "Bougie parfumée lilas",
  "Carnet de notes mauve", "Écharpe en soie prune", "Coussin velours violet",
  "Vase en verre améthyste", "Tapis doux pour salon", "Diffuseur d’huiles essentielles",
  "Montre au bracelet violet", "Sac à main aubergine", "Bouteille d’eau réutilisable",
  "Casque audio violet", "Poster abstrait violet", "Plante artificielle violet",
  "Coque de téléphone lilas", "Baskets avec accents violets", "Chapeau en feutre prune"
]

User.where(role: "seller").each do |seller|
  rand(30..40).times do
    name = product_names.sample
    seed = URI.encode_www_form_component("violet_" + name)  # ajout du préfixe violet pour la cohérence

    # URL image Picsum
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
