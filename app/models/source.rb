# frozen_string_literal: true

class Source < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions
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
