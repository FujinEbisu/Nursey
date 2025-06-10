class Message < ApplicationRecord
  belongs_to :mother
  belongs_to :doctor
  belongs_to :chat
end
