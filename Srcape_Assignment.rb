require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'active_record'

$recipe1 = Array.new
doc = Nokogiri::HTML(open('http://www.simplyrecipes.com/index/'))

$recipe2 = Array.new 
doc.xpath('//*[contains(concat( " ", @class, " " ), concat( " ", "entry-content", " " ))]//p/a/@href').each do |node|
  $recipe2 << node.text
  end

doc.xpath('//*[contains(concat( " ", @class, " " ), concat( " ", "entry-content", " " ))]//p/a').each do |node|
  $recipe1 << node.text
 end

$recipe2.each do |a1|
puts a1
end

$recipe1.each do |a2|
puts a2
end

class Rubyist < ActiveRecord::Base  
end 

ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => "localhost",  
:database => "ruby",
:password => "admin"  
)  

while $j<700 do
$val1=$recipe2.at($j)
$val2=$recipe1.at($j)
Recipe.create(:Recipe_name => $val2,:Link => $val1)
$j +=1
end


