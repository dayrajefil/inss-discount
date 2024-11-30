# frozen_string_literal: true

# app/controllers/reports_controller.rb
class ReportsController < ApplicationController
  def proponent_salary
    salary_brackets = [
      { range: (0..1045), label: 'Até R$ 1.045,00' },
      { range: (1045.01..2089.60), label: 'De R$ 1.045,01 a R$ 2.089,60' },
      { range: (2089.61..3134.40), label: 'De R$ 2.089,61 até R$ 3.134,40' },
      { range: (3134.41..6101.06), label: 'De R$ 3.134,41 até R$ 6.101,06' },
      { range: (6101.07..Float::INFINITY), label: 'Acima de R$ 6.101,06' }
    ]

    @salary_groups = salary_brackets.map do |bracket|
      count = Proponent.where(salary: bracket[:range]).count
      { label: bracket[:label], count: count }
    end
  end
end
