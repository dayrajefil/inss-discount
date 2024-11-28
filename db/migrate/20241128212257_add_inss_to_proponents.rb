class AddInssToProponents < ActiveRecord::Migration[7.1]
  def change
    add_column :proponents, :inss, :decimal, precision: 10, scale: 2
  end
end
