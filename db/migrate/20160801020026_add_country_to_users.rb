class AddCountryToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :country, foreign_key: true, nil: true, default: 70
  end
end
