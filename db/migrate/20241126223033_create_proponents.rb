# frozen_string_literal: true

# CreateProponents é uma migração responsável por criar a tabela `proponents` no banco de dados.
# A tabela inclui campos para o nome (name), data de nascimento (birthdate), telefone (phone),
# salário (salary) com precisão de 10 dígitos e 2 casas decimais,
# e uma referência para o endereço (address), que é uma chave estrangeira para a tabela `addresses`.
#  A migração também inclui os campos padrão de timestamps (created_at e updated_at).
#
class CreateProponents < ActiveRecord::Migration[7.1]
  def change
    create_table :proponents do |t|
      t.string :name
      t.date :birthdate
      t.string :phone
      t.decimal :salary, precision: 10, scale: 2
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
