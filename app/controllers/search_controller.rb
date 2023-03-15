class SearchController < ApplicationController
  def index
    @repositories = github_client.get_repositories(params[:query])
      .paginate(page: params[:page], per_page: 5)
  end

  private

  def github_client
    ::GithubService.new(retries: 3, timeout: 5)
  end
end
