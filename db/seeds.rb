# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "1"
p kubilay = User.new(name: "Kubilay", encrypted_password: "000000", email: "k@k.com")
p kubilay.save!
p User.create(name: "Marios", encrypted_password: "000000", email: "m@m.com")

p Friendship.create(sender_id: 1, receiver_id: 2)
puts "2"
