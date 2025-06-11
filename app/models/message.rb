class Message < ApplicationRecord
  belongs_to :mother
  belongs_to :doctor
  belongs_to :chat

  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to "chat_#{chat.id}_messages",
                        partial: "chats/message",
                        target: "messages",
                        locals: { message: self, user: sender }
    chat.update(unread: true)
    broadcast_replace_to "chat_#{doctor.id}",
                        partial: "chats/card_message_mother",
                        target: "newmessage-#{chat.id}",
                        locals: { chat: chat }
  end

end
