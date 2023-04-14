require './lib/candidate'
require './lib/race'

RSpec.describe Race do
  before(:each) do
    @race = Race.new("Texas Governor")
  end

  describe "#initializes" do
    it "initializes" do
      expect(@race).to be_an_instance_of(Race)
    end

    it "initializes with attributes" do
      expect(@race.office).to eq("Texas Governor")
      expect(@race.candidates).to eq([])
    end
  end

  describe "#register_candidate! && candidates" do
    it "can create && register candidates" do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})

      expect(candidate1.class).to eq(Candidate)
      expect(candidate1.name).to eq("Diana D")
      expect(candidate1.party).to eq(:democrat)
    end

    it "can list all the candidates in the race" do
      candidate1 = @race.register_candidate!({name: "Diana D", party: :democrat})
      candidate2 = @race.register_candidate!({name: "Roberto R", party: :republican})

      expect(@race.candidates).to eq([candidate1, candidate2])
    end
  end

  describe "#open? && #close!" do
    before(:each) do
      @presidential = Race.new("Presidential")
      @ny_governor = Race.new("Governor of New York")
      @ny_senator = Race.new("New York Senator")
    end

    it "can determine if a race is open" do
      expect(@presidential.open?).to be(true)
    end

    it "can close the race" do
      @presidential.close!
      expect(@presidential.open?).to be(false)
    end
  end
end