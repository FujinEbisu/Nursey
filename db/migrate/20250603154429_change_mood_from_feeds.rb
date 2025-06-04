class ChangeMoodFromFeeds < ActiveRecord::Migration[7.1]
  def change
    remove_column :feeds, :mood
    add_column :feeds, :mood, :integer

  end
end
