# frozen_string_literal: true

module Summaries
    class Generate
      include Interactor

      def call
        context.fail! if generate_summary.invalid?

        context.summary = generate_summary
      end

      private

      def generate_summary
        @summary ||= begin
                       content = context.content
                       response = Client::Ai.generate(content.content)["response"]
                       json = JSON.parse(response)
                       Summary.create(content: content,
                                      summary: json["summary"],
                                      context: json["context"],
                                      principal_facts: json["principal_facts"],
                                      conclusion: json["conclusion"])
                     end
      end
    end
end
