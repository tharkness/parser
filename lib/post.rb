require 'nokogiri'
require 'pry'
require_relative '../spec/spec_helper'
class Post

  attr_reader :title, :url, :points, :item_id, :comments

  def initialize(title, url, points, item_id)
    @title = title
    @url = url
    @points = points
    @item_id = item_id
    @comments = []
  end

  def comments
    @comments
  end

  def add_comment(comment)
    @comments << comment.to_s
  end

  def create_comment(doc, user_idx, idx)
    user = doc.search('.comhead > a')[user_idx].inner_text
    time = doc.search('.comhead > .age')[idx].inner_text
    text = doc.search('.comment')[idx].inner_text
    return Comment.new(user, time, text)
  end

  def create_comments
    i = 1
    x = 0
    html_file = open('post.html')
    post = html_file.read
    doc = Nokogiri::HTML(post)
    (doc.search('.comment').length).times do
      some = create_comment(doc, i, x)
      i += 1
      x += 1
      add_comment(some)
    end
  end
  
end














