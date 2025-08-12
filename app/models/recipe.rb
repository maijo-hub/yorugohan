class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :dinner_recipes, dependent: :destroy
  has_many :dinners, through: :dinner_recipes

  validates :title, presence: { message: 'タイトルは必須です' }, length: { maximum: 100, message: 'タイトルは100文字以内で入力してください' }
  
  scope :with_active_users, -> {
    joins(:user).where(users: { is_deleted: false })
  }
end
