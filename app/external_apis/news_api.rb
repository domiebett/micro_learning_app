require 'news-api'

class NewsApi
  def initialize(api_key)
    @news_api = News.new(api_key)
  end

  def fetch_articles(topic_name)
    @news_api.get_everything(
      q: topic_name,
      language: 'en',
      sortBy: 'relevance'
    )
  end
end
