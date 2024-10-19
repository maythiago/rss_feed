require "rails_helper"

RSpec.describe FeedController, type: :controller do
  describe 'GET #index' do
    it 'assigns @newsitems' do
      allow(Client::Rss).to receive(:fetch_rss_feed).and_return(['newsitem1', 'newsitem2'])
      get :index
      expect(assigns(:newsitems)).to eq(['newsitem1', 'newsitem_2'])
    end
  end

  describe 'POST #summary' do
    let(:news_title) { 'Sample Title' }
    let(:content) { 'Sample content for AI summary.' }
    let(:ai_response) { { 'response' => 'Summarized content.' } }

    before do
      allow(Client::Ai).to receive(:generate).with(content).and_return(ai_response)
    end

    it 'renders the turbo stream response' do
      post :summary, params: { feed_title: news_title, feed_content: content }
      expect(response).to render_template(partial: 'feed/_summary')
      expect(assigns(:summary)).to eq('Summarized content.')
    end
  end
end
