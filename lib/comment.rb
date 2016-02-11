class Comment

  attr_reader :user, :time, :text

  def initialize(user, time, text)
    @user = user
    @time = time
    @text = text
  end

  def find_user(doc, user_idx)
    # doc.search('.comhead > a')[user_idx].inner_text
  end

  def find_time(doc, idx)
    # doc.search('.comhead > .age')[idx].inner_text
  end

  def find_text(doc, idx)
    # doc.search('.comment')[idx].inner_text
  end

end