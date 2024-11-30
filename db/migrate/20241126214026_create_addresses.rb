# frozen_string_literal: true

# CreateAddresses é uma migração responsável por criar a tabela `addresses` no banco de dados.
# A tabela inclui campos para o código postal (zip_code), rua (street), número (number),
# complemento (complement), bairro (neighborhood), cidade (city) e estado (state), além dos
# campos padrão de timestamps (created_at e updated_at).
#
class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :zip_code, null: false
      t.string :street, null: false
      t.string :number, null: false
      t.string :complement
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :state, null: false

      t.timestamps
    end
  end
end
