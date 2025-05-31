# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# db/seeds.rb

# Créer un utilisateur vendeur
seller = User.find_or_create_by!(email: "seller@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.firstname = "seller"
  user.lastname = "1"
  user.role = "seller" if user.respond_to?(:role)  # si tu gères les rôles
end

# Vérifie que le seller est bien persisté
raise "Erreur: le vendeur n'a pas été créé" unless seller.persisted?

# Crée 10 produits pour ce vendeur
10.times do |i|
  Product.create!(
    name: "Produit #{i + 1}",
    image_url: "https://picsum.photos/200/200?random=#{i + 1}",
    price: rand(10..100),
    description: "Description du produit #{i + 1}",
    user: seller
  )
end

puts "✅ 1 vendeur créé et 10 produits associés."
