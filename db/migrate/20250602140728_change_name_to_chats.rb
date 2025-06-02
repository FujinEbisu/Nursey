class ChangeNameToChats < ActiveRecord::Migration[7.1]
  def change
    rename_table :chats, :messages
  end
end
