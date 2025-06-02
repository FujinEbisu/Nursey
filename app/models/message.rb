class Message < ApplicationRecord
  belongs_to :mother
  belongs_to :doctor
end
