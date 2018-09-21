class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.datetime :date, null: false
      t.string :code, null: false
      t.string :description
      t.string :type
      t.decimal :amount, null: false
      t.decimal :real_amount, null: false
      t.decimal :box_amount, null: false
      t.decimal :box_all_amount, null: false
      t.references :currency, null: false
      t.decimal :rate, null: false
      t.references :employee
      t.timestamps
    end
  end
end
