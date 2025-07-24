class User < ApplicationRecord
  has_many :dinners, dependent: :destroy
  has_many :recipes, dependent: :destroy 
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  def active_for_authentication?
    super && !is_deleted
  end
end
