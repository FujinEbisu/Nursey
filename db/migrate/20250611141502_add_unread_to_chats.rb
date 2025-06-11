class AddUnreadToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :unread, :boolean, default: false
  end
end
