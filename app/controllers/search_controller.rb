class SearchController < ApplicationController
  def index
    @repositories = github_client.get_repositories(params[:query])
  end

  private

  def github_client
    ::GithubService.new(retries: 3, timeout: 5)
  end
end
