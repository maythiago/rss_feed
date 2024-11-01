class CreateContexts < ActiveRecord::Migration[7.2]
  def change
    create_table :contexts do |t|
      t.text :summary
      t.text :principal_fact, array: true, default: []
      t.text :conclusion
      t.text :context

      t.timestamps
    end
  end
end
