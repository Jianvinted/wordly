# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create(username: "secretuser")

for n in 1..6 do 
    Game.create(status: true, row: n, user_id: user.id)
end 
for n in 1..5 do 
    Game.create(status: false, row: n, user_id: user.id)
end 


