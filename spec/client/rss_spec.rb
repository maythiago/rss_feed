# frozen_string_literal: true

RSpec.describe Client::Rss do
  describe '.ssfeed' do
    let(:url) { 'http://example.com/rss' }
    let(:rsscontent) do
      <<-RSS
      <rss version="2.0">
        <channel>
          <title>Example RSS</title>
          <link>http://example.com/</link>
          <description>Example RSS Feed</description>
          <item>
            <title>Example Item</title>
            <link>http://example.com/item1</link>
            <guid>item1</guid>
            <description>Example Description</description>
            <pubDate>Mon, 01 Jan 2023 00:00:00 +0000</pubDate>
            content:encodedExample Content</content:encoded>
          </item>
        </channel>
      </rss>
      RSS
    end

    before do
      allow(URI).to receive(:open).with(url).and_return(StringIO.new(rss_content))
    end

    it 'returns an array of news items' do
      result = described_class.fetch_rss_feed(url)
      expect(result).to be_an(Array)
      expect(result.size).to eq(1)
    end

    it 'parses the RSS feed correctly' do
      result = described_class.fetch_rss_feed(url)
      expect(result.first[:title]).to eq('Example Item')
      expect(result.first[:link]).to eq('http://example.com/item1')
      expect(result.first[:guid]).to eq('item1')
      expect(result.first[:description]).to eq('Example Description')
      expect(result.first[:pub_date]).to eq('Mon, 01 Jan 2023 00:00:00 +0000')
      expect(result.first[:content]).to eq('Example Content')
    end
  end
end
