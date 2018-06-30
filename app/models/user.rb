require 'sinatra/activerecord'
require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :first_name, :last_name, :email, presence: true
  validates_format_of :email,
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, uniqueness: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :password_hash, length: { minimum: 6 }

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
end
