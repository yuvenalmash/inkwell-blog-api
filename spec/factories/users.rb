require 'faker'

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username.slice(0, 20) }
    email { Faker::Internet.email.slice(0, 50) }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
