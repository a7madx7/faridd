class AddContentsToDrugs < ActiveRecord::Migration[5.0]
  def change
    add_column :drugs, :contents, :decimal
  end
end
