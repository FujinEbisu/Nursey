class AddColumnToChildren < ActiveRecord::Migration[7.1]
  def change
    add_column :children, :sexe, :string
  end
end
