class CreateMothers < ActiveRecord::Migration[7.1]
  def change
    create_table :mothers do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.integer :time_between_feed

      t.timestamps
    end
  end
end
