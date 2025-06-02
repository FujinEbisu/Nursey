class CreateChildren < ActiveRecord::Migration[7.1]
  def change
    create_table :children do |t|
      t.string :first_name
      t.references :mother, null: false, foreign_key: true

      t.timestamps
    end
  end
end
