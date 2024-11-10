# frozen_string_literal: true

FactoryBot.define do
  factory :source do
    url { 'www.google.com' }
  end
end

# == Schema Information
#
# Table name: sources
#
#  id         :bigint           not null, primary key
#  name       :string
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
