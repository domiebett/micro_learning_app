require 'news-api'

class NewsApi
  def initialize
    @news_api = News.new('dca162428fd344318bb51036cbe37695')
  end

  def fetch_articles(topic_name)
    api_articles = @news_api.get_everything(
      q: topic_name,
      language: 'en',
      sortBy: 'popularity'
    )

    format_articles(api_articles)
  end

  def format_articles(articles)
    articles.map do |article|
      {
        title: article.title,
        description: article.description,
        author: article.author,
        url: article.url,
        image_url: article.urlToImage
      }
    end
  end
end
