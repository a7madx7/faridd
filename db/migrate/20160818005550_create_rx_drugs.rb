class CreateRxDrugs < ActiveRecord::Migration[5.0]
  def change
    create_table :rx_drugs do |t|

      t.timestamps
    end
  end
end
