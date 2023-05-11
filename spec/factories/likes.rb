require 'faker'

FactoryBot.define do
  factory :like do
    user
    association :likeable, factory: :post
    # If the likeable is a comment, the associaton below will be used
    trait :comment do
      association :likeable, factory: :comment
    end
  end
end
