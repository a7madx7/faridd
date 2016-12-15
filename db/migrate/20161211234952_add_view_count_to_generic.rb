class AddViewCountToGeneric < ActiveRecord::Migration[5.0]
  def change
    add_column :generics, :view_count, :integer, default: 0, null: false
  end
end
