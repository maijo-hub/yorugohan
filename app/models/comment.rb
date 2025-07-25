class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :dinner

  validates :content, presence: true
  scope :by_users_not_deleted, -> {
    left_joins(:user).where(users: { is_deleted: [false, nil] })
  }
end
