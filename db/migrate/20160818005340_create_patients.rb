class CreatePatients < ActiveRecord::Migration[5.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.decimal :age
      t.datetime :birth_day
      t.text :patient_history

      t.timestamps
    end
  end
end
