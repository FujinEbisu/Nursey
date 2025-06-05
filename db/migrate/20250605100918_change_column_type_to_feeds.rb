class ChangeColumnTypeToFeeds < ActiveRecord::Migration[7.1]
  def change
    rename_column :feeds, :type, :nursy_type
  end
end
