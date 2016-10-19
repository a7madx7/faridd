class CreateRxDrugs < ActiveRecord::Migration[5.0]
  def change
    create_table :rx_drugs do |t|
      t.integer :drug_id
      t.integer :rx_id
      t.timestamps
    end
  end
end
