class Review < ApplicationRecord
  belongs_to :user
  belongs_to :dinner

  scope :by_active_users, -> { joins(:user).where(users: { is_deleted: false }) }
end
