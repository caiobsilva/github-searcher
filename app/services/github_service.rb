require "faraday/retry"

class GithubService
  GITHUB_API_URL = "https://api.github.com/".freeze

  def initialize(retries: 3, timeout: 5)
    @conn = Faraday.new(url: GITHUB_API_URL) do |f|
      f.request :retry, max: retries, interval: 0.5
      f.options.timeout = timeout
    end
  end

  def get_repositories(query)
    Rails.cache.fetch(["repositories", query], expires_in: 1.hour) do
      response = get("search/repositories", q: query)

      response[:items].map do |item|
        Repository.new(
          name: item[:name],
          owner: item.dig(:owner, :login),
          description: item[:description],
          stars: item[:stargazers_count],
          url: item[:html_url]
        )
      end
    end
  end

  private

  def get(endpoint, **params)
    response = @conn.get(endpoint, **params) do |req|
      req.headers["Content-Type"] = "application/json"
    end

    JSON.parse(response.body).with_indifferent_access
  end
end
