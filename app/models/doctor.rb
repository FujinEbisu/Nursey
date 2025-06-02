class Doctor < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_one :user, as: :userable, dependent: :destroy
end
