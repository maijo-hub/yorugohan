class CreateDinnerRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :dinner_recipes do |t|
      t.references :dinner, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
