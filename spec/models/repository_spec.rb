require "rails_helper"

RSpec.describe Repository, type: :model do
  describe "#initialize" do
    subject { Repository.new(**attrs) }

    context "when all attributes are provided" do
      let(:attrs) do
        {
          name: "name",
          owner: "owner",
          description: "description",
          stars: 1,
          url: "url"
        }
      end

      it "sets all attributes" do
        expect(subject.name).to eq(attrs[:name])
        expect(subject.owner).to eq(attrs[:owner])
        expect(subject.description).to eq(attrs[:description])
        expect(subject.stars).to eq(attrs[:stars])
        expect(subject.url).to eq(attrs[:url])
      end
    end

    context "when some attributes are missing" do
      let(:attrs) do
        {
          name: "name",
          url: "url"
        }
      end

      it "raises an error" do
        expect { subject }.to raise_error("Repository attributes cannot be empty!")
      end
    end
  end
end
