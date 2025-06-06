class Mother < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :feeds, through: :children
  has_one :user, as: :userable, dependent: :destroy
  has_one_attached :avatar
end
