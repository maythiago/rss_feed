require 'rails_helper'

RSpec.describe Summaries::Generate do
  describe '.call' do
    let(:content) { create(:content) }
    let(:context) { { content: content } }

    context 'when summary valid' do
      before do
        response = { "summary" => "Summary text", "context" => "Context text", "principal_facts" => [ "Fact 1", "Fact 2" ], "conclusion" => "Conclusion text" }.to_json
        allow(Client::Ai).to receive(:generate).with(content.content).and_return({ "response" => response })
      end

      it 'creates a summary record with the correct attributes' do
        result = described_class.call(context)

        expect(result).to be_success
        summary = result.summary
        expect(summary.external_id).to eq(content.identifier)
        expect(summary.summary).to eq("Summary text")
        expect(summary.context).to eq("Context text")
        expect(summary.principal_facts).to eq([ "Fact 1", "Fact 2" ])
        expect(summary.conclusion).to eq("Conclusion text")
      end
    end

    context 'when summary invalid' do
      before do
        response = { "summary" => "", "context" => "", "principal_facts" => [], "conclusion" => "" }.to_json
        allow(Client::Ai).to receive(:generate).with(content.content).and_return({ "response" => response })
      end

      it 'raises an error if the summary cannot be created' do
        expect(described_class.call(context)).to be_failure
      end
    end
  end
end
