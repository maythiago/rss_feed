# frozen_string_literal: true

class FeedController < ApplicationController
  URL = "https://www.brasildefato.com.br/rss2.xml"

  def index
    @news_items = Client::Rss.fetch_rss_feed(URL)
  end

  def summary
    news_title = params[:feed_title]
    content = params[:feed_content]

    summary = Client::Ai.generate(content)["response"]

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("feed_summary_#{news_title.parameterize}", partial: "feed/summary", locals: { summary: summary }) }
    end
  end
end
