class Review < ApplicationRecord
  belongs_to :safe_place
  belongs_to :mother
end
