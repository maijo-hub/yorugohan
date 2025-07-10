class DinnerRecipe < ApplicationRecord
  belongs_to :dinner
  belongs_to :recipe
end
