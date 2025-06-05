class AddAvatarToDoctors < ActiveRecord::Migration[7.1]
  def change
    add_column :doctors, :avatar, :string
  end
end
