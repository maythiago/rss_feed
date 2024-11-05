class CreateSummaries < ActiveRecord::Migration[7.2]
  def change
    create_table :summaries do |t|
      t.text :summary
      t.text :principal_facts, array: true, default: []
      t.text :conclusion
      t.text :context

      t.timestamps
    end
  end
end
