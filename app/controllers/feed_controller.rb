# frozen_string_literal: true

class FeedController < ApplicationController
  URL = "https://www.brasildefato.com.br/rss2.xml"

  def index
    @news_items = news
  end

  def summary
    news_title = params[:feed_title]
    news_guid = params[:feed_guid]
    content = news.find { |item| item[:guid] == news_guid }

    summary = Client::Ai.generate(content)["response"]
    json = JSON.parse(summary)
    p "=" * 100
    p json
    p "=" * 100

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("feed_summary_#{news_guid.parameterize}", partial: "feed/summary", locals: { summary: json }) }
    end
  end

  private

  def news
    @news ||= urls.map do |url|
     Client::Rss.fetch_rss_feed(url)
    end.flatten
  end

  def urls
    Source.all.pluck(:url)
  end
end
