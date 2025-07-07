class PostImage < ApplicationRecord
  belongs_to :user

  # Active Storageで画像を1つ添付する
  has_one_attached :image

  # タグの扱い方やバリデーションもここで設定可能
  validates :description, presence: true, length: { maximum: 30 }
end