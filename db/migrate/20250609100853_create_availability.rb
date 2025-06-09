class CreateAvailability < ActiveRecord::Migration[7.1]
  def change
    create_table :availabilities do |t|
      t.date :date
      t.references :doctor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
