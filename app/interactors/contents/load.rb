# frozen_string_literal: true

module Contents
    class Load
      include Interactor

      def call
        sources = context.sources

        sources.each do |source|
          result = Client::Rss.fetch_rss_feed(source.url)

          result.each do |item|
            Content.find_or_create_by!(identifier: item[:guid], source: source) do |content|
              content.title = item[:title]
              content.content = item[:content]
              content.pub_date = item[:pub_date]
            end
          end
        end.flatten
      end
    end
end
