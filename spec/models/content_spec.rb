require 'rails_helper'

RSpec.describe Content, type: :model do
  subject { build(:content) }

  context 'associations' do
    it { should belong_to(:source) }
    it { should have_one(:summary).dependent(:destroy) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:pub_date) }
    it { should validate_presence_of(:identifier) }
    it { should validate_uniqueness_of(:identifier).scoped_to(:source_id) }
  end
end

# == Schema Information
#
# Table name: contents
#
#  id           :bigint           not null, primary key
#  content      :text
#  identifier   :string(255)
#  lock_version :integer
#  pub_date     :datetime
#  title        :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  source_id    :bigint           not null
#
# Indexes
#
#  index_contents_on_source_id  (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (source_id => sources.id)
#
