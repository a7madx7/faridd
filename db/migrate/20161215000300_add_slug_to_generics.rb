class AddSlugToGenerics < ActiveRecord::Migration[5.0]
  def change
    add_column :generics, :slug, :string
    add_index :generics, :slug
  end
end
