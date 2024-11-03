require 'rails_helper'

RSpec.describe Summary, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
