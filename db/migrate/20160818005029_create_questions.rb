class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title, unique: true, null: false
      t.text :content, unique: true, null: false
      t.references :user, foreign_key: true
      t.decimal :rating, null: true

      t.timestamps
    end
  end
end
