class AddFormToDrugs < ActiveRecord::Migration[5.0]
  def change
    add_reference :drugs, :form, foreign_key: true
  end
end
