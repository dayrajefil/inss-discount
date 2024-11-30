# frozen_string_literal: true

# AddDiscountedSalaryToProponents é uma migração responsável por adicionar a coluna `discounted_salary`
# à tabela `proponents`. A coluna `discounted_salary` é do tipo decimal com precisão de 10 dígitos e 2
# casas decimais, para armazenar o salário com desconto.
#
class AddDiscountedSalaryToProponents < ActiveRecord::Migration[7.1]
  def change
    add_column :proponents, :discounted_salary, :decimal, precision: 10, scale: 2
  end
end
