class AddUserIdToRxes < ActiveRecord::Migration[5.0]
  def change
    add_column :rxes, :user_id, :integer
  end
end
