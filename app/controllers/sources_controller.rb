# frozen_string_literal: true

class SourcesController < ApplicationController
  before_action :authenticate_user!

  def index
    @sources = current_user.sources
  end

  def destroy
    # remove only subscription
    current_user.sources.delete(Source.find(params[:id]))
    redirect_to source_index_path
  end

  def new
    @source = Source.new
  end

  def create
    if rss.nil?
      render :new, status: :unprocessable_entity
      return
    end

    @source = Source.find_or_create_by(url: source_params[:url])
    @source.users << current_user
    @source.update(name: rss[:title], url: source_params[:url])

    redirect_to sources_path
  end

  def rss
    return unless valid_url?(source_params[:url])

    @rss ||= Client::Rss.fetch_channel_info(source_params[:url])
  end

  def source_params
    params.require(:source).permit(:url)
  end

  def valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end
