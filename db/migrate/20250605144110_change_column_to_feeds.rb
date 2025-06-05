class ChangeColumnToFeeds < ActiveRecord::Migration[7.1]
  def change
    change_column_null :feeds, :child_id, true
  end
end
