class RemoveUserToMothers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :mothers, :user, index: true, foreign_key: true
  end
end
