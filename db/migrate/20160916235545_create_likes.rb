class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :article_id, null: true
      t.integer :comment_id, null: true
      t.integer :rx_id, null: true
      t.integer :formulation_id, null: true
      t.integer :category_id, null: true
      t.integer :company_id, null: true
      t.integer :question_id, null: true
      t.integer :generic_id, null: true

      t.timestamps
    end
  end
end
