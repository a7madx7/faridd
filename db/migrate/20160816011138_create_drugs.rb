class CreateDrugs < ActiveRecord::Migration[5.0]
  def change
    create_table :drugs do |t|
      t.string :name
      t.references :country, foreign_key: true
      t.references :category, foreign_key: true

      t.float :price
      t.float :concentration
      t.string :unit

      t.timestamps
    end
  end
end
