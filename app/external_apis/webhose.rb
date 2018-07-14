class Webhose
  BASE_URL = "https://webhose.io/"

  def initialize
    @next = ''
    @token = 'b85923f6-ab71-4184-9884-bcae14c3e4c0'
  end

  def query(end_point_str, param_dict = {})
    param_dict[:token] ||= @token
    param_dict[:format] ||= 'json'
    @next = URI::parse(BASE_URL + end_point_str + '?' + URI.encode_www_form(param_dict))
    get_next
  end

  def get_next
    response = Net::HTTP.get_response(@next)

    unless response.kind_of? Net::HTTPSuccess
      raise 'Server replied with status code ' + response.code
    end

    json = JSON.parse(response.body)
    @next = URI::parse(BASE_URL + json['next'])
    json
  end

  def fetch_articles(topic_name)
    articles = query('filterWebContent', {q: topic_name})
    format_articles(articles['posts'])
  end

  def format_articles(articles)
    articles.map do |article|
      {
          title: article['title'],
          url: article['url'],
          author: article['author'],
          description: article['text']
      }
    end
  end
end
