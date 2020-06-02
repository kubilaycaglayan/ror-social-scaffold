# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "SEEEDING"
names = ["Kubilay", "Marios", "Gandalf", "Frodo", "Kirk Hammett", "Gimmlik", "Boromir"]
mails = ["a@a.com", "b@b.com", "c@c.com", "d@d.com", "e@e.com", "f@f.com", "g@g.com"]

names.each_with_index do |name, index|
  user = User.new
  user.name = name
  user.email = mails[index]
  user.password = '000000'
  user.password_confirmation = '000000'
  user.save!
end

Friendship.create(user_id: 1, friend_id: 2)
Friendship.create(user_id: 2, friend_id: 1)

Friendship.create(user_id: 3, friend_id: 2)
Friendship.create(user_id: 3, friend_id: 1)

Friendship.create(user_id: 4, friend_id: 2)
Friendship.create(user_id: 4, friend_id: 1)

Friendship.create(user_id: 5, friend_id: 2)
Friendship.create(user_id: 5, friend_id: 1)

Friendship.create(user_id: 6, friend_id: 2)
Friendship.create(user_id: 6, friend_id: 1)


puts "SEEEDING DONE"
