# frozen_string_literal: true

class FeedController < ApplicationController
  before_action :load_news, only: %i[index]

  def index
    @contents = contents
  end

  def summary
    summary_model = fetch_summary

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
    Summaries::Generate.call(content: content).summary
  end

  def contents
    @contents ||= Content.all.order(pub_date: :desc)
  end

  def load_news
    Contents::Load.call(sources: sources)
  end

  def sources
    Source.all
  end
end
