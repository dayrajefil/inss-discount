# frozen_string_literal: true

# AddInssToProponents é uma migração responsável por adicionar a coluna `inss` à tabela `proponents`.
# A coluna `inss` é do tipo decimal com precisão de 10 dígitos e 2 casas decimais.
#
class AddInssToProponents < ActiveRecord::Migration[7.1]
  def change
    add_column :proponents, :inss, :decimal, precision: 10, scale: 2
  end
end
