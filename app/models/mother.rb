class Mother < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :feeds, through: :children
  has_many :chats, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one :user, as: :userable, dependent: :destroy

end
