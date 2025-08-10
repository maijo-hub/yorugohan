class ChangeDatatypeIsDeletedOfUsers < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :is_deleted, :boolean, default: false
  end

  def down
    change_column :users, :is_deleted, :boolean
  end
end
