class AddStatusToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :closed, :boolean, default: false
  end
end
