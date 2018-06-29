require 'sinatra/activerecord'
require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
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
