# frozen_string_literal: true

class Summary < ApplicationRecord
  def principal_facts
    JSON.parse(principal_fact)
  end
end

# == Schema Information
#
# Table name: summaries
#
#  id             :bigint           not null, primary key
#  conclusion     :text
#  context        :text
#  principal_fact :text
#  summary        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  external_id    :string
#
