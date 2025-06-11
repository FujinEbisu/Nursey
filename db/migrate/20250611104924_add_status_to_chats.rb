class AddStatusToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :status, :string, default: "ouvert", null: false
  end
end
