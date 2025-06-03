class Doctor < ApplicationRecord
  has_one :user, as: :userable, dependent: :destroy
end
