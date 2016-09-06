class AddImageUrlToDrug < ActiveRecord::Migration[5.0]
  def change
    add_column :drugs, :image_url, :string
  end
end
