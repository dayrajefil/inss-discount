# frozen_string_literal: true

# CalculateDiscountedSalaryJob é uma classe de job que calcula o salário com desconto
# do proponente, subtraindo o valor do INSS do salário bruto.
#
# O job é executado de forma assíncrona e, ao ser processado, encontra o proponente
# correspondente pelo `proponent_id`, calcula o valor do salário com desconto e
# atualiza o registro do proponente com esse valor.
#
# O job é enfileirado para ser processado na fila padrão (`:default`).
#
class CalculateDiscountedSalaryJob < ApplicationJob
  queue_as :default

  def perform(proponent_id)
    proponent = Proponent.find(proponent_id)
    discounted_salary = proponent.salary - proponent.inss
    proponent.update(discounted_salary: discounted_salary)
  end
end
