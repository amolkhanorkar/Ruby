require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'active_record'
require 'mysql2'

ActiveRecord::Base.establish_connection ({:adapter => "mysql2", :host => "localhost", :username => "root", :password => "admin", :database => "ruby"})
class Recipe < ActiveRecord::Base 
end 

#...........variables...........#
$recipe_ingredient=""
$recipe_method=""

#.........Recipe Category..........#
doc = Nokogiri::HTML(open('http://www.simplyrecipes.com/index/'))
doc.xpath('//div[@class="entry-content"]/p/a/@href').each_with_index do |node,i|
puts node.text
#..........Recipe List...........#
  doc = Nokogiri::HTML(open(node.text))
    doc.xpath('//header[@class="entry-header"]/h2/a/@href').each do |node1|
    puts node1.text
#...........Recipe Name..........#
doc = Nokogiri::HTML(open(node1.text))
        doc.xpath('//div[@class="recipe-callout"]/h2').each do |node2|
        
#............Ingredients............#
doc.xpath('//div[@class="recipe-callout"]/div[@id="recipe-ingredients"]/ul/li').each do |ingredients|
    $recipe_ingredient.concat(ingredients.text)
    $recipe_ingredient.concat(",")
    end
#............Method.............#
doc.xpath('//div[@class="recipe-callout"]/div[@id="recipe-method"]/div[@itemprop="recipeInstructions"]/p').each do |method|
   $recipe_method.concat(method.text)
   $recipe_method.concat(",")
  end

Recipe.create(:Recipe_Name => node2.text, :Ingredient => $recipe_ingredient, :Method =>$recipe_method)

$recipe_ingredient=""
$recipe_method=""
end
end
break if i==5
end

