class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :doc, null: false
      t.string :names, null: false
      t.string :last_names, null: false
      t.datetime :birth_date, null: false
      t.datetime :admission_date, null: false, default: DateTime.now
      t.datetime :exit_date
      t.timestamps
    end
  end
end
