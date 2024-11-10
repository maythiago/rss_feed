# frozen_string_literal: true

class Content < ApplicationRecord
  belongs_to :source
  has_one :summary, dependent: :destroy

  validates :title, :identifier, presence: true
  validates :identifier, uniqueness: { scope: :source_id }
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
