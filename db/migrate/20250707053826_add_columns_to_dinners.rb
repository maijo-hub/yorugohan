class AddColumnsToDinners < ActiveRecord::Migration[6.1]
  def change
    add_column :dinners, :image, :string
    add_column :dinners, :user_id, :integer
  end
end
