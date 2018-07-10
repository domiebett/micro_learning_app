require 'sinatra/activerecord'
require 'bcrypt'

require_relative '../services/email'

class User < ActiveRecord::Base
  include BCrypt

  validates :first_name, :last_name, :email, presence: true
  validates_format_of :email,
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, uniqueness: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :password_hash, length: { minimum: 6 }

  has_many :user_topics
  has_many :topics, through: :user_topics

  has_many :sent_articles, dependent: :destroy

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password) unless new_password.length < 6
    self.password_hash = @password
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    is_admin
  end

  def send_article
    user_articles = topics.each.map(&:articles).flatten
    articles_not_sent = user_articles.select do |article|
      sent_articles.where(article_id: article.id).first.nil?
    end
    random_article = articles_not_sent.sample
    unless random_article.nil?
      email_service = Email.new(full_name, email)
      email_service.send_article(random_article)
    end
  end
end
