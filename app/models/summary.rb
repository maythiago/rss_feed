# frozen_string_literal: true

class Summary < ApplicationRecord
  validates :summary, presence: true
  validates :context, presence: true
  validates :principal_facts, presence: true
  validates :conclusion, presence: true

  belongs_to :content
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
#  content_id      :bigint
#
# Indexes
#
#  index_summaries_on_content_id  (content_id)
#
