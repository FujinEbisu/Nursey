class RemoveAddColumnToFeeds < ActiveRecord::Migration[7.1]
  def change
    remove_column :feeds, :time_left
    remove_column :feeds, :time_right
    add_column :feeds, :time_left, :integer, default: 0
    add_column :feeds, :time_right, :integer, default: 0
  end
end
