# frozen_string_literal: true

class AddSummaryToContent < ActiveRecord::Migration[7.2]
  def change
    add_reference :summaries, :content
  end
end
