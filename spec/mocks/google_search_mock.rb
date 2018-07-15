class GoogleSearchMock
  def fetch_articles(topic_name='topic')
    MockArticle.new.articles
  end
end