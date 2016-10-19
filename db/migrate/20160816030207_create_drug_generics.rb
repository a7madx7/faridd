class CreateDrugGenerics < ActiveRecord::Migration[5.0]
  def change
    create_table :drug_generics do |t|
      t.integer :drug_id, null: true
      t.integer :generic_id, null: true
    end
  end
end
