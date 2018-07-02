require 'bcrypt'

FactoryBot.define do
  factory :user do
    first_name 'Dominic'
    last_name 'Bett'
    email 'bett@example.com'
    password_hash BCrypt::Password.create('password')
  end
end
