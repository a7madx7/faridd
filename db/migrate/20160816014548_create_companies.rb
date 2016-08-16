class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.references :drug, foreign_key: true
      t.references :country, foreign_key: true
      t.float :reputation

      t.timestamps
    end
  end
end
