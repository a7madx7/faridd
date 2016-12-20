class RemoveCategoryIdFromDrugs < ActiveRecord::Migration[5.0]
  def change
    remove_column :drugs, :category_id
  end
end
