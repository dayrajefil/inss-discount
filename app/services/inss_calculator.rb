# app/services/inss_calculator.rb
# https://www.gov.br/inss/pt-br/direitos-e-deveres/inscricao-e-contribuicao/tabela-de-contribuicao-mensal

class InssCalculator
  def self.calculate(salary)
    brackets = [
      { limit: 0.00, rate: 0.075 },
      { limit: 1_045.00, rate: 0.09 },
      { limit: 2_089.60, rate: 0.12 },
      { limit: 3_134.40, rate: 0.14 },
      { limit: 6_101.06, rate: 0.14 }
    ]

    total_inss = 0
    remaining_salary = salary

    brackets.each_with_index do |bracket, index|
      next_limit = brackets[index + 1]&.[](:limit) || remaining_salary

      if remaining_salary > bracket[:limit]
        taxable_income = [next_limit, remaining_salary].min - bracket[:limit]
        total_inss += (taxable_income * bracket[:rate]).round(2)
      end
    end

    total_inss.round(2)
  end
end
