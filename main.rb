require 'open-uri'
require_relative 'lib/post'
require 'nokogiri'

html_file = open(ARGV[0])
post = html_file.read

doc = Nokogiri::HTML(post)


def create_post(doc)
  title = doc.search('td.title a')[0].inner_text
  points = doc.search('td.subtext span')[0].inner_text
  id = get_id(doc)
  url = doc.search('td.title a')[1].inner_text
  return Post.new(title, url, points, id)
end

def get_id(doc)
  doc.search('td.subtext a')[1].attributes.values.map do |i|
    /\d+/.match(i.to_s)[0]
  end
end

# def comment_loop
#   html_file = open('post.html')
#   post = html_file.read
#   doc = Nokogiri::HTML(post)
#   i = 1
#   x = 0
#   doc.search('.comhead').length do |i, x|
#     comm = Comment.new(doc, i, x)
#     something.add_comment(comm)
#     i += 1
#     x += 1
#   end
# end

# def create_comment
#   user = doc.search('.comhead > a')[user_idx].inner_text
#   time = doc.search('.comhead > .age')[idx].inner_text
#   text = doc.search('.comment')[idx].inner_text
#   return Comment.new()
# end

posty = create_post(doc)

posty.create_comments

puts "Post title: #{posty.title}"
puts "Number of Comments: #{posty.comments.length}"
puts "This post has #{posty.points}"
puts "The item id of this post is: #{posty.item_id}"
puts "This post links to: #{posty.url}"
