class CreateContents < ActiveRecord::Migration[7.2]
  def change
    create_table :contents do |t|
      t.text :title
      t.text :content
      t.string :identifier, limit: 255
      t.integer :lock_version
      t.references :source, null: false, foreign_key: true

      t.timestamps
    end
  end
end
