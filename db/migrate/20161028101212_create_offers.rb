class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.integer :drug_id
      t.integer :user_id
      t.decimal :discount
      t.datetime :expiry
      t.integer :amount

      t.timestamps
    end
  end
end
