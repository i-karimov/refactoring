# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::Name.first_name }
    surname { FFaker::Name.last_name }
    patronymic { FFaker::Lorem.word }
    email { FFaker::Internet.email }
    age { rand(22..88) }
    nationality { "from #{FFaker::Address.country}" }
    country { FFaker::Address.country }
    sequence(:full_name) { |n| "user#{n}" }
  end
end
