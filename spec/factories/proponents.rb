# frozen_string_literal: true

# spec/factories/proponents.rb
FactoryBot.define do
  factory :proponent do
    name { Faker::Name.name }
    birthdate { Faker::Date.between(from: Date.today - 100.years, to: Date.today) }
    phone { Faker::PhoneNumber.cell_phone }
    salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    association :address
  end
end
