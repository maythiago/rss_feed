# frozen_string_literal: true

class FeedController < ApplicationController
  URL = "https://www.brasildefato.com.br/rss2.xml"

  def index
    @news_items = news
  end

  def summary
    news_title = params[:feed_title]
    news_guid = params[:feed_guid]
    summary_model = fetch_summary(news_guid)

    pp summary_model

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("feed_summary_#{news_guid.parameterize}", partial: "feed/summary", locals: { summary: summary_model }) }
    end
  end

  private

  def fetch_summary(external_id)
    Summary.find_by(external_id: external_id) || generate_summary(external_id)
  end

  def generate_summary(external_id)
    content = news.find { |item| item[:guid] == external_id }
    response = Client::Ai.generate(content)["response"]
    json = JSON.parse(response)

    Summary.create!(external_id: external_id, summary: json["summary"], context: json["context"], principal_facts: json["principal_facts"], conclusion: json["conclusion"])
  end

  def news
    @news ||= urls.map do |url|
     Client::Rss.fetch_rss_feed(url)
    end.flatten
  end

  def urls
    Source.all.pluck(:url)
  end
end
