# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts 'Destroy doses'
Dose.destroy_all if Rails.env.development?
puts 'Destroy ingredients'
Ingredient.destroy_all if Rails.env.development?
puts 'Destroy Cocktails'
Cocktail.destroy_all if Rails.env.development?

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

ingredients = JSON.parse(open(url).read)
ingredients['drinks'].each { |ingredient| Ingredient.create(name: ingredient.values[0]) }

url_cocktail = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"

cocktails = JSON.parse(open(url_cocktail).read)
cocktails['drinks'].each do |cocktail|
  img = URI.open(cocktail['strDrinkThumb'])
  @cocktail = Cocktail.new(name: cocktail['strDrink'])
  @cocktail.photo.attach(io: img, filename: "#{cocktail['strDrink']}.png", content_type: 'image/png')
  @cocktail.save

  url_doses = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{cocktail['idDrink']}"

  doses = JSON.parse(open(url_doses).read)

  doses['drinks'].each do |dose|
    i = 1
    c_ingredient = dose["strIngredient#{i}"]
    until c_ingredient.nil?
      search_ingredient = Ingredient.where(name: c_ingredient)
      ingr = search_ingredient[0].nil? ? Ingredient.create(name: c_ingredient) : search_ingredient[0]
      Dose.create(description: dose["strMeasure#{i}"], cocktail_id: @cocktail.id, ingredient_id: ingr.id)
      i += 1
      c_ingredient = dose["strIngredient#{i}"]
    end
  end
end
puts 'SUCCESS'
