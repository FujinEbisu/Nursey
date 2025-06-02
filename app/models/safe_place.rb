class SafePlace < ApplicationRecord
  has_many :safe_places, dependent: :destroy
end
