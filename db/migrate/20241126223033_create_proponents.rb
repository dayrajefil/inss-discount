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
