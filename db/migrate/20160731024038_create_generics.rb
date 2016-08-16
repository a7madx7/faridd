class CreateGenerics < ActiveRecord::Migration[5.0]
  def change
    create_table :generics do |t|
      t.string :name
      t.datetime :invented_at

      t.timestamps
    end
  end
end
