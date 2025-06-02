class Feed < ApplicationRecord
  belongs_to :mother
  belongs_to :child
end
