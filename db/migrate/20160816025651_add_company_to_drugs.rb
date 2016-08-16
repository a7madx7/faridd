class AddCompanyToDrugs < ActiveRecord::Migration[5.0]
  def change
    add_reference :drugs, :company, foreign_key: true
  end
end
