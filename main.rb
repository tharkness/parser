require 'open-uri'
require_relative 'lib/post'
require 'nokogiri'
require 'pry'

html_file = open(ARGV[0])
post = html_file.read

doc = Nokogiri::HTML(post)


def create_post(doc)
  title = doc.search('td.title a')[0].inner_text
  points = doc.search('td.subtext span')[0].inner_text
  id = get_id(doc)
  url = doc.xpath("//td[@class='title']/a/@href").first.value
  return Post.new(title, url, points, id)
end

def get_id(doc)
  first = doc.xpath("//td[@class='subtext']/span[@class='age']/a/@href").first.value
  first[/\d+/]
end

posty = create_post(doc)

posty.create_comments

puts "Post title: #{posty.title}"
puts "Number of Comments: #{posty.comments.length}"
puts "This post has #{posty.points}"
puts "The item id of this post is: #{posty.item_id}"
puts "This post links to: #{posty.url}"
