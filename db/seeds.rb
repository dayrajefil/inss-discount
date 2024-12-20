# frozen_string_literal: true

require 'faker'
require 'net/http'
require 'json'

zip_codes = %w[
  03122-050 13611-412 13611-412 09411-180 13843-180
  18277-540 13201-057 07145-245 05797-190 02960-100
  11724-555 11724-555 13451-095 18078-425 08574-500
  74482-412 75043-203 74393-470 75800-454 74653-170
]

Faker::Config.locale = 'pt-BR'

zip_codes.each do |zip_code|
  uri = URI("https://viacep.com.br/ws/#{zip_code}/json/")
  response = Net::HTTP.get(uri)
  address_data = JSON.parse(response)

  if address_data['erro']
    puts "CEP inválido: #{zip_code}. Gerando um novo."
    redo
  end

  address = Address.create!(
    street: address_data['logradouro'],
    number: Faker::Number.between(from: 1, to: 1000),
    neighborhood: address_data['bairro'],
    city: address_data['localidade'],
    state: address_data['uf'],
    zip_code: address_data['cep']
  )

  salary = Faker::Number.decimal(l_digits: 4, r_digits: 2)
  inss = InssCalculator.calculate(salary)

  Proponent.create!(
    name: Faker::Name.name,
    birthdate: Faker::Date.between(from: Date.today - 100.years, to: Date.today),
    phone: Faker::PhoneNumber.cell_phone,
    salary: salary,
    inss: inss,
    address: address
  )
end

puts 'Successfully created data!'
