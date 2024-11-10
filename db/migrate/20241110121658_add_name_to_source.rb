class AddNameToSource < ActiveRecord::Migration[7.2]
  def change
    add_column :sources, :name, :string
  end
end
