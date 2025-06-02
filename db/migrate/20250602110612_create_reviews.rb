class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.float :rating
      t.references :safe_place, null: false, foreign_key: true
      t.references :mother, null: false, foreign_key: true

      t.timestamps
    end
  end
end
