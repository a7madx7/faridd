class CreateDrugCategory < ActiveRecord::Migration[5.0]
  def change
    create_table :drug_categories do |t|
      t.integer :drug_id
      t.integer :category_id
    end
  end
end
