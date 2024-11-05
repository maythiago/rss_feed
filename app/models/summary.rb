# frozen_string_literal: true

class Summary < ApplicationRecord
end

# == Schema Information
#
# Table name: summaries
#
#  id              :bigint           not null, primary key
#  conclusion      :text
#  context         :text
#  principal_facts :text             default([]), is an Array
#  summary         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  external_id     :string
#
