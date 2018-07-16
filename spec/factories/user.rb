require 'bcrypt'

FactoryBot.define do
  factory :user do
    first_name 'Dom'
    last_name 'Bett'
    password_hash BCrypt::Password.create('password')

    factory :admin do
      email 'dbett49@gmail.com'
      is_admin true
    end

    factory :normal_user do
      email 'bett@example.com'
      is_admin false
    end
  end
end
