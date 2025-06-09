class DeleteAvailabilityToDoctors < ActiveRecord::Migration[7.1]
  def change
    remove_column :doctors, :availability
  end
end
