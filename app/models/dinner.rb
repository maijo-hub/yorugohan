class Dinner < ApplicationRecord
  scope :active, -> { includes(:user).where('user.is_deleted': false) } 
  
  belongs_to :user
  has_one_attached :image
  has_many :dinner_recipes, dependent: :destroy
  has_many :recipes, through: :dinner_recipes
  has_many :comments, dependent: :destroy
  has_many :dinner_tags, dependent: :destroy
  has_many :tags, through: :dinner_tags

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :image, presence: true


end
