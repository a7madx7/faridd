class CreateArticleComments < ActiveRecord::Migration[5.0]
  def change
    create_table :article_comments do |t|
      t.integer :article_id, null: true
      t.integer :comment_id, null: true

      t.timestamps
    end
  end
end
