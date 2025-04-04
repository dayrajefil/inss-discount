# frozen_string_literal: true

# InssCalculator é uma classe responsável por calcular o valor da contribuição
# do INSS com base no salário informado. Ela aplica as faixas de contribuição
# de acordo com a tabela vigente e retorna o valor total do INSS a ser descontado.
#
#  https://www.gov.br/inss/pt-br/direitos-e-deveres/inscricao-e-contribuicao/tabela-de-contribuicao-mensal
#
class InssCalculator
  def self.calculate(salary)
    brackets = [
      { limit: 1_412.00, rate: 0.075 },
      { limit: 2_666.68, rate: 0.09 },
      { limit: 4_000.03, rate: 0.12 },
      { limit: 7_786.02, rate: 0.14 },
      { limit: Float::INFINITY, rate: 0.14 }
    ]

    total_inss = 0
    remaining_salary = salary

    brackets.each_with_index do |bracket, index|
      current_limit = if brackets[index][:limit] == Float::INFINITY
                        remaining_salary
                      else
                        brackets[index][:limit]
                      end

      last_limit = index.zero? ? 0.0 : brackets[index - 1][:limit]

      unless remaining_salary < last_limit
        taxable_income = (current_limit - last_limit).round(2)
        total_inss += (taxable_income * bracket[:rate]).round(2)
      end
    end

    total_inss.round(2)
  end
end
