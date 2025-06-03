class AddColumnToFeeds < ActiveRecord::Migration[7.1]
  def change
    add_column :feeds, :comment, :text
  end
end
