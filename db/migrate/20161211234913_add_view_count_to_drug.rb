class AddViewCountToDrug < ActiveRecord::Migration[5.0]
  def change
    add_column :drugs, :view_count, :integer
  end
end
