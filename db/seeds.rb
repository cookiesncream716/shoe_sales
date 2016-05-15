# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(first_name: "Jane", last_name: "Doe", email:"jane@gmail.com", password: "password", password_confirmation: "password")
User.create(first_name: "Lucy", last_name: "Jones", email:"lucy@gmail.com", password: "password", password_confirmation: "password")
User.create(first_name: "Sally", last_name: "Smith", email:"sally@gmail.com", password: "password", password_confirmation: "password")

Shoe.create(product: "orange sandals", user: User.first, price: 5.00)
Shoe.create(product: "gray cowboy boots", user: User.second, price: 10.50)
Shoe.create(product: "black heels", user: User.third, price: 7.00)
Shoe.create(product: "pink flats", user: User.first, price: 3.00)
