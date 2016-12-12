class AddViewCountToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :view_count, :integer
  end
end
