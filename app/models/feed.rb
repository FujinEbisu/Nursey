class Feed < ApplicationRecord
  belongs_to :mother
  belongs_to :child
  enum mood: {
    happy: 5,
    content: 4,
    neutral: 3,
    annoyed: 2,
    unhappy: 1
  }
end
