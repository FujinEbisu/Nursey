class AddDefaultTimeToMothers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :mothers, :time_between_feed, 2
  end
end
