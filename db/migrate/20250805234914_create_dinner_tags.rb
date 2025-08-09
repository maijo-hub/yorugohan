class CreateDinnerTags < ActiveRecord::Migration[6.1]
  def change
    create_table :dinner_tags do |t|
      t.references :dinner, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
