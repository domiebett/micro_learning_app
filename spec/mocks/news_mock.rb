require_relative 'article_mock'

class NewsMock
  def get_everything(*args)
    [MockArticle.new]
  end
end