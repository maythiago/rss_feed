# frozen_string_literal: true

module Client
  class Rss
    # Test with rspec
    def self.fetch_rss_feed(url)
      news_items = []
      URI.open(url) do |rss|
        feed = RSS::Parser.parse(rss, validate: false)
        feed.items.each do |item|
          news_items << {
            title: item.title,
            link: item.link,
            guid: item.guid&.content&.presence || item.link.presence || item.title,
            description: item.description,
            pub_date: item.pubDate,
            content: item.content_encoded
          }
        end
      end

      news_items
    end

    def self.fetch_channel_info(url)
      begin
        channel = nil
        URI.open(url) do |rss|
          feed = RSS::Parser.parse(rss, validate: false)
          channel =  {
            title: feed.channel.title
          }
        end
        channel
      rescue => e
          pp e
        nil
      end
    end
  end
end
