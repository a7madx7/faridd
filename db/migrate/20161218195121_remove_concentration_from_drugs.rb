class RemoveConcentrationFromDrugs < ActiveRecord::Migration[5.0]
  def change
    remove_column :drugs, :concentration
    remove_column :drugs, :unit
  end
end
