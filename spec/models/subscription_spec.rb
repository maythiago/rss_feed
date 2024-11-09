require 'rails_helper'

RSpec.describe Subscription, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:source) }
  end
end

# == Schema Information
#
# Table name: subscriptions
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  source_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_source_id  (source_id)
#  index_subscriptions_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (source_id => sources.id)
#  fk_rails_...  (user_id => users.id)
#
