class CalculateDiscountedSalaryJob < ApplicationJob
  queue_as :default

  def perform(proponent_id)
    proponent = Proponent.find(proponent_id)
    discounted_salary = proponent.salary - proponent.inss
    proponent.update(discounted_salary: discounted_salary)
  end
end
