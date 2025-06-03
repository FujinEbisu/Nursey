class Mother < ApplicationRecord
  has_many :children, dependent: :destroy
  has_many :feeds, through: :children
  has_one :user, as: :userable, dependent: :destroy

end
