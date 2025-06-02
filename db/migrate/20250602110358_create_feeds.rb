class CreateFeeds < ActiveRecord::Migration[7.1]
  def change
    create_table :feeds do |t|
      t.string :type
      t.references :mother, null: false, foreign_key: true
      t.references :child, null: false, foreign_key: true
      t.timestamp :time_left
      t.timestamp :time_right
      t.float :quantity_left
      t.float :quantity_right
      t.string :mood

      t.timestamps
    end
  end
end
