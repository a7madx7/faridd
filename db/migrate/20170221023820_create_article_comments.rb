class CreateArticleComments < ActiveRecord::Migration[5.0]
  def change
    create_table :article_comments do |t|
      t.references :article, foreign_key: true
      t.references :comment, foreign_key: true
    end
  end
end
