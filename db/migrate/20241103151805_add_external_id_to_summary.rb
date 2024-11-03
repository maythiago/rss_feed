# frozen_string_literal: true

class AddExternalIdToSummary < ActiveRecord::Migration[7.2]
  def change
    add_column :summaries, :external_id, :string
  end
end
