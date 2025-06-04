class ChangeColumnTypeToMothers < ActiveRecord::Migration[7.1]
  def change
    change_column :mothers, :birthday, :date
  end
end
