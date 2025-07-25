class Dinner < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :dinner_recipes, dependent: :destroy
  has_many :recipes, through: :dinner_recipes
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 500 }
  validates :image, presence: true
  scope :with_active_users, -> {
    joins(:user).where(users: { is_deleted: [false, nil] })
  }

end
