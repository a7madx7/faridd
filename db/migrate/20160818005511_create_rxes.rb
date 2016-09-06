class CreateRxes < ActiveRecord::Migration[5.0]
  def change
    create_table :rxes do |t|
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end
