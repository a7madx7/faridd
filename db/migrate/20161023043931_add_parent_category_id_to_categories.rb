class AddParentCategoryIdToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :parent_category_id, :integer
  end
end
