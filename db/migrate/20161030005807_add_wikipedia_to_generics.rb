class AddWikipediaToGenerics < ActiveRecord::Migration[5.0]
  def change
    add_column :generics, :wikipedia_page_url, :string
    add_column :generics, :wikipedia_summary, :text
    add_column :generics, :wikipedia_image_urls, :string
    add_column :generics, :wikipedia_links, :string
    add_column :generics, :wikipedia_extlinks, :string
  end
end
