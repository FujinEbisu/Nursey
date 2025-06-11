class Chat < ApplicationRecord
  belongs_to :mother
  belongs_to :doctor
  has_many :messages, dependent: :destroy
end
