require 'rails_helper'

RSpec.describe Summary, type: :model do
  context 'validations' do
    it { should validate_presence_of(:summary) }
    it { should validate_presence_of(:context) }
    it { should validate_presence_of(:principal_facts) }
    it { should validate_presence_of(:conclusion) }
  end

  context 'associations' do
    it { should belong_to(:content) }
  end
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
