# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# 10.times do 
#   User.create(
#     firstname: Faker::Name.first_name, 
#     lastname: Faker::Name.last_name, 
#     email: Faker::Internet.email, 
#     password: Faker::Internet.password
#   )
# end


list = Imdb::Top250.new


list.movies.each do |movie|
  new_movie = Movie.create(title: movie.title.split(" ").join(" ").gsub(/^\d+\./,''), director: movie.director[0], description: movie.plot, runtime_in_minutes: movie.length, release_date: movie.release_date, poster_image_url: movie.poster)
  end  

