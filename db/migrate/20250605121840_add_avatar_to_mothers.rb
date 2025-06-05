class AddAvatarToMothers < ActiveRecord::Migration[7.1]
  def change
    add_column :mothers, :avatar, :string
  end
end
