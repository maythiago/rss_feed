# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contents::Load do
  describe '.call' do
    let(:source) { create(:source) }
    let(:context) { { sources: [ source ] } }
    let(:rss_feed) do
      [
        { guid: '1', title: 'Title 1', content: 'Content 1', pub_date: '2023-10-01' },
        { guid: '2', title: 'Title 2', content: 'Content 2', pub_date: '2023-10-02' }
      ]
    end

    before do
      allow(Client::Rss).to receive(:fetch_rss_feed).with(source.url).and_return(rss_feed)
    end

    it 'creates new content records from the RSS feed' do
      expect { described_class.call(context) }.to change { Content.count }.by(2)
    end

    it 'does not create duplicate content records' do
      described_class.call(context)
      expect { described_class.call(context) }.not_to change { Content.count }
    end

    it 'sets the correct attributes on the content records' do
      described_class.call(context)
      content = Content.find_by(identifier: '1')
      expect(content.title).to eq('Title 1')
      expect(content.content).to eq('Content 1')
      expect(content.pub_date).to eq('2023-10-01')
    end
  end
end
