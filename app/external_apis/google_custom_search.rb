class GoogleCustomSearch
  BASE_URL = 'https://www.googleapis.com/customsearch/v1'.freeze

  def initialize
    @api_key = 'AIzaSyA9NfPWll85uLhTh2k5fQZiRSe-ETJojnk'
    @cx = '013548527467310995633:93nqxnz1gam'
    @uri = ''
  end

  def query(param_dict = {})
    param_dict[:key] ||= @api_key
    param_dict[:cx] ||= @cx
    param_dict[:q] ||= ''
    @uri = URI.parse("#{BASE_URL}?#{URI.encode_www_form(param_dict)}")

    get_contents
  end

  def get_contents
    response = Net::HTTP.get_response(@uri)

    unless response.is_a? Net::HTTPSuccess
      raise 'Server replied with status code ' + response.code
    end

    JSON.parse(response.body)
  end

  def fetch_articles(topic_name)
    articles = query(q: topic_name)
    puts "Articles"
    puts articles
    format_articles articles['items']
  end

  def format_articles(articles)
    articles.map do |article|
      {
        title: article['title'],
        url: article['formattedUrl'],
        author: article['displayLink'],
        description: article['snippet']
      }
    end
  end
end
