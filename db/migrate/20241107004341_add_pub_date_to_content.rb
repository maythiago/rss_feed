# frozen_string_literal: true

class AddPubDateToContent < ActiveRecord::Migration[7.2]
  def change
    add_column :contents, :pub_date, :datetime
  end
end
