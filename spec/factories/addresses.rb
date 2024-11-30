# spec/factories/addresses.rb
FactoryBot.define do
  factory :address do
    # Faker::Config.locale = 'pt-BR'

    zip_code { Faker::Address.zip_code }
    street { Faker::Address.street_name }
    number { Faker::Number.between(from: 1, to: 1000) }
    neighborhood { %w[Centro Jardins Vila Alto Novo].sample }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
  end
end
