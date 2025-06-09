class Doctor < ApplicationRecord
  has_one :user, as: :userable, dependent: :destroy
  has_one_attached :avatar
  has_many :messages
end
