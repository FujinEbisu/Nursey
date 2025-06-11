class Chat < ApplicationRecord
  belongs_to :mother
  belongs_to :doctor
  has_many :messages, dependent: :destroy

   after_create_commit :broadcast_chat



  private

  def broadcast_chat
    broadcast_append_to "chat_#{doctor.id}",
                        partial: "chats/card_message_mother",
                        target: "chats",
                        locals: { chats: self }
  end
end
