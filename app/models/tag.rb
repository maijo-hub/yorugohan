class Tag < ApplicationRecord
  has_many :dinner_tags, dependent: :destroy
  has_many :dinners, through: :dinner_tags
end

