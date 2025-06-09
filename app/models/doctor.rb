class Doctor < ApplicationRecord
  has_one :user, as: :userable, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_one_attached :avatar
  has_many :messages

  attr_accessor :availability
end
