class Doctor < ApplicationRecord
  has_one :user, as: :userable, dependent: :destroy
  has_many :availabilities, dependent: :destroy
end
