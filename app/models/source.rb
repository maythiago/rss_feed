# frozen_string_literal: true

class Source < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions
  validates :url,  presence: true
  validates :url, uniqueness: true
  has_many :contents, dependent: :destroy
  validate :valid_url
  validate :url_is_rss

  private

  def valid_url
    errors.add(:url, "is not a valid URL") unless valid_url?(url)
  end

  def url_is_rss
    errors.add(:url, "is not a valid RSS feed") unless rss?
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end

  def rss?
    rss.present?
  end

  def rss
    Client::Rss.fetch_channel_info(url)
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
