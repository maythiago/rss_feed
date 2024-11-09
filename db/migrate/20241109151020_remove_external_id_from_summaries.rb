# frozen_string_literal: true

class RemoveExternalIdFromSummaries < ActiveRecord::Migration[7.2]
  def change
    remove_column :summaries, :external_id
  end
end
