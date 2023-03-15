require "rails_helper"

RSpec.describe SearchController, type: :controller do
  describe "GET #index" do
    subject { get :index, params: { query: "repo" } }

    it "renders the view for search#index" do
      expect_any_instance_of(GithubService).to receive(:get_repositories).with("repo")
      expect(subject).to render_template(:index)
    end
  end
end
