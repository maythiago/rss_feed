# frozen_string_literal: true

class FeedController < ApplicationController
  URL = "https://www.brasildefato.com.br/rss2.xml"
  before_action :load_news, only: %i[index]

  def index
    @contents = contents
  end

  def summary
    summary_model = fetch_summary(news_guid)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("feed_summary_#{content.id}", partial: "feed/summary", locals: { summary: summary_model }) }
    end
  end

  private

  def content_id
    params[:content_id]
  end

  def content
    @content ||= Content.find(content_id)
  end

  def fetch_summary
    Summary.find_by(external_id: content.identifier) || generate_summary
  end

  def generate_summary
    response = Client::Ai.generate(content.content)["response"]
    json = JSON.parse(response)

    Summary.create!(external_id: content.identifier, summary: json["summary"], context: json["context"], principal_facts: json["principal_facts"], conclusion: json["conclusion"])
  end

  def contents
    @contents ||= Content.all.order(pub_date: :desc)
  end

  def load_news
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

  def sources
    Source.all
  end
end
