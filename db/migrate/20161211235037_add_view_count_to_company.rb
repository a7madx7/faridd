class AddViewCountToCompany < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :view_count, :integer
  end
end
