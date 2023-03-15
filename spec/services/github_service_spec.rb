require "rails_helper"

RSpec.describe GithubService, type: :service do
  describe "#get_repositories" do
    subject do
      described_class.new(retries: 1, timeout: 0).get_repositories("query")
    end

    let(:url) do
      "#{described_class::GITHUB_API_URL}search/repositories?q=query"
    end

    context "when the request is successful" do
      before do
        stub_request(:get, url).to_return(body: body.to_json)
      end

      context "and the response has items" do
        let(:body) do
          {
            items: [{
              name: "name",
              owner: { login: "owner" },
              description: "description",
              stargazers_count: 1,
              html_url: "url"
            }]
          }
        end

        it "returns a cached array of repositories" do
          expect(::Rails.cache).to receive(:fetch)
            .with(["repositories", "query"], expires_in: 1.hour)
            .and_call_original

          expect(subject).to all(be_a(Repository))
        end
      end

      context "and the response does not have items" do
        let(:body) { {} }

        it "returns an empty array" do
          expect(::Rails.cache).to receive(:fetch)
            .with(["repositories", "query"], expires_in: 1.hour)
            .and_call_original

          expect(subject).to eq([])
        end
      end
    end

    context "when the request fails" do
      before do
        stub_request(:get, url).to_raise(Faraday::TimeoutError)
      end

      it "retries the request" do
        expect { subject }.to raise_error(Faraday::TimeoutError)

        expect(WebMock).to have_requested(:get, url).twice
      end
    end
  end
end
