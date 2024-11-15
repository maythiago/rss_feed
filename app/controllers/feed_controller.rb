# frozen_string_literal: true

class FeedController < ApplicationController
  before_action :authenticate_user!
  before_action :load_news, only: %i[index]

  def index
    @contents = contents
  end

  def summary
    summary_model = fetch_summary

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("modal", partial: "feed/summary_modal", locals: { summary: summary_model, content: content }) }
      format.html { render partial: "feed/summary_modal", locals: { summary: summary_model, content: content } }
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
    Summary.find_by(content: content) || generate_summary
  end

  def generate_summary
    Summaries::Generate.call(content: content).summary
  end

  def contents
    @contents ||= current_user.contents.includes([ :source ]).order(pub_date: :desc)
  end

  def load_news
    Contents::Load.call(sources: sources)
  end

  def sources
    current_user.sources
  end
end
