class AddDiscountedSalaryToProponents < ActiveRecord::Migration[7.1]
  def change
    add_column :proponents, :discounted_salary, :decimal, precision: 10, scale: 2
  end
end
