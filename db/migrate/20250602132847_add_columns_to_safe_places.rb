class AddColumnsToSafePlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :safe_places, :latitude, :float
    add_column :safe_places, :longitude, :float
  end
end
