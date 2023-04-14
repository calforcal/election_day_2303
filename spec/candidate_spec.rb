require './lib/candidate'

RSpec.describe Candidate do
  before(:each) do
    @diana = Candidate.new({name: "Diana D", party: :democrat})
  end

  describe "#initialize" do
    it "initializes" do
      expect(@diana).to be_an_instance_of(Candidate)
    end

    it "initializes with attributes" do
      expect(@diana.name).to eq("Diana D")
      expect(@diana.party).to eq(:democrat)
    end
  end

  describe "#votes && vote_for!" do
    it "can receive votes" do
      expect(@diana.votes).to eq(0)

      @diana.vote_for!
      @diana.vote_for!
      @diana.vote_for!

      expect(@diana.votes).to eq(3)

      @diana.vote_for!

      expect(@diana.votes).to eq(4)
    end
  end
end