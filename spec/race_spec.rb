require './lib/candidate'
require './lib/race'
require './lib/election'

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
      @election = Election.new("2024")
      @election.add_race(@presidential)
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

  describe "#winner && #tie" do
    before(:each) do
      @election = Election.new("2024")
      @election.add_race(@presidential)
      @presidential = Race.new("Presidential")
      @ny_governor = Race.new("Governor of New York")
      @ny_senator = Race.new("New York Senator")
    end

    it "is false if a race is open" do
      expect(@presidential.open?).to be(true)
      expect(@presidential.winner).to be(false)
    end

    it "determines a winner if race is closed" do
      presidential_candidate_1 = @presidential.register_candidate!({name: "Robert Gunnut", party: :republican})
      presidential_candidate_2 = @presidential.register_candidate!({name: "Andy Leftwich", party: :democrat})
      5.times { presidential_candidate_1.vote_for! }
      101.times { presidential_candidate_2.vote_for! }
      @presidential.close!
      expect(@presidential.winner).to eq(presidential_candidate_2)
    end

    # it "can determine if theres a tie" do
    #   presidential_candidate_1 = @presidential.register_candidate!({name: "Robert Gunnut", party: :republican})
    #   presidential_candidate_2 = @presidential.register_candidate!({name: "Andy Leftwich", party: :democrat})
    #   5.times { presidential_candidate_1.vote_for! }
    #   5.times { presidential_candidate_2.vote_for! }
    #   @presidential.close!
    #   expect(@presidential.tie?).to eq(true)
    # end
  end
end