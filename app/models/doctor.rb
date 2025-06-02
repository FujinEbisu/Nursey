class Doctor < ApplicationRecord
  has_many :chats, dependent: :destroy
end
