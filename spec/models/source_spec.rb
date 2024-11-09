require 'rails_helper'

RSpec.describe Source, type: :model do
  context 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
  end

  context 'associations' do
    it { should have_many(:users) }
    it { should have_many(:subscriptions) }
  end
end

# == Schema Information
#
# Table name: sources
#
#  id         :bigint           not null, primary key
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
