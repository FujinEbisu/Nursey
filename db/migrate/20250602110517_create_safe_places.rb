class CreateSafePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :safe_places do |t|
      t.string :name
      t.string :adress
      t.text :options

      t.timestamps
    end
  end
end
