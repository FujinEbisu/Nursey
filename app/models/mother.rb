class Mother < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :feeds, through: :children
  has_many :chats, dependent: :destroy

  validates :name, presence: true
end
