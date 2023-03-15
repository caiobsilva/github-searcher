require "rails_helper"

RSpec.describe HomeController, type: :controller do
  context "GET #index" do
    subject { get :index }

    it { is_expected.to render_template(:index) }
  end
end
