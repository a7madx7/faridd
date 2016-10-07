class CreateDrugCategory < ActiveRecord::Migration[5.0]
  def change
    # todo: rename it to categories_drugs
    create_table :drug_categories, id: false do |t|
      t.integer :drug_id
      t.integer :category_id
    end
  end
end
