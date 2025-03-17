# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create admin user
User.create(email: "admin@utrgv.edu", password: "adminpass", role: "admin")

# Create regular users
5.times do |i|
  User.create(email: "user#{i}@utrgv.edu", password: "password123", role: "user")
end

# Create lost and found items
LostItem.create(name: "Laptop", description: "Silver MacBook", location: "Library", category: "Electronics", user: User.first)
FoundItem.create(name: "Wallet", description: "Brown leather wallet", location: "Cafeteria", category: "Accessories", user: User.last)
