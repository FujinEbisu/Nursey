class Review < ApplicationRecord
  belongs_to :safe_place
  belongs_to :mother
  enum rating: {
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5
  }
end
