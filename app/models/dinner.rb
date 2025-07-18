class Dinner < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :dinner_recipes, dependent: :destroy
  has_many :recipes, through: :dinner_recipes

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :image, presence: true
end
