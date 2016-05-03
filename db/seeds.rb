require 'faker'

# admin = User.new(first_name: 'kevin', last_name: 'sia', email: 'kevin@example.com')
# admin.save_password('123qwe')
# admin.save

# 19.times do
#   user = User.new(first_name: Faker::Name.name,
#                   last_name: Faker::Name.name,
#                   email: Faker::Internet.email)
#   user.save_password('123456')
#   user.save

# end

# # create status for each user
# User.all.each do |user|
#   rand(5..10).times do
#     user.statuses.create(content: Faker::Hipster.sentence(rand(2..3)))
#   end
# end

until Friendship.count == 20 do
  rand_number = rand(1..20)
  rand_number_2 = rand(1..20)
  next if rand_number_2 == rand_number
  Friendship.create(user_id: rand(1..20), friend_id: rand(1..20))
end
