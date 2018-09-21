class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :sign, null: false
      t.decimal :rate, null: false
      t.timestamps
    end
  end
end
