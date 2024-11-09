class SourceController < ApplicationController
  before_action :authenticate_user!

  def index
    @sources = current_user.sources
  end

  def destroy
    # remove only subscription
    current_user.sources.delete(Source.find(params[:id]))
    redirect_to source_index_path
  end
end
