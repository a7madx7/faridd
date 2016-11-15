class CreateFormulations < ActiveRecord::Migration[5.0]
  def change
    create_table :formulations do |t|
      t.integer :generic_id
      t.text :steps
      t.integer :category_id
      t.integer :comment_id
      t.integer :like_id

      t.timestamps
    end
  end
end
