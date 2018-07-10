class MockArticle
  def initialize(title = 'title', description = 'description', author = 'author', url = 'url')
    @title = title
    @description = description
    @author = author
    @url = url
  end

  attr_reader :title, :description, :author, :url
end
