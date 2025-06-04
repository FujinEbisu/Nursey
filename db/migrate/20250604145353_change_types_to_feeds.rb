class ChangeTypesToFeeds < ActiveRecord::Migration[7.1]
  def change
     remove_column :feeds, :time_left
    add_column :feeds, :time_left, :time
    remove_column :feeds, :time_right
    add_column :feeds, :time_right, :time
  end
end
