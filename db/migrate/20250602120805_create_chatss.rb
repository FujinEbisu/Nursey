class CreateChatss < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.text :content
      t.references :mother, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
