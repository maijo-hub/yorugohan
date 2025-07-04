class CreateDinners < ActiveRecord::Migration[6.1]
  def change
    create_table :dinners do |t|
      t.string :title
      t.string :body
      t.string :tags
      t.timestamps
    end
  end
end
