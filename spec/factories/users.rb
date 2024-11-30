# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) do |n|
      letters = ('a'..'z').to_a
      first_letter = letters[(n - 1) / 26]
      second_letter = letters[(n - 1) % 26]

      "user.#{first_letter}#{second_letter}"
    end

    sequence(:email) { |n| "user#{n}@email.com" }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
