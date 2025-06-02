class Child < ApplicationRecord
  belongs_to :mother
  has_many :feeds, dependent: :destroy
end
