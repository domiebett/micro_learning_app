require 'pony'

class Email
  def initialize(name, email)
    @name = name
    @email = email
    @app_email = 'microlearningapp@gmail.com'
  end

  def send_article(article)
    email_subject = 'Daily Learning Page'
    email_body = %(
      title: #{article.title}
      description: #{article.description}
      url: #{article.url}
    )

    Pony.mail(
      to: @email,
      from: @app_email,
      subject: email_subject,
      body: email_body
    )
    puts "Email has been sent to #{@name}"
  end
end
