require 'faker'

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username.slice(0, 20) }
    email { Faker::Internet.email.slice(0, 50) }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
