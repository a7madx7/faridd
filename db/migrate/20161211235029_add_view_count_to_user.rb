class AddViewCountToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :view_count, :integer, default: 0, null: false
  end
end
