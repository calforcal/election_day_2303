require './lib/candidate'
require './lib/race'
require './lib/election'

RSpec.describe Election do
  before(:each) do
    @election = Election.new("2024")
  end

  describe "#initialize" do
    it "initializes" do
      expect(@election).to be_an_instance_of(Election)
    end

    it "initializes with attributes" do
      expect(@election.year).to eq("2024")
      expect(@election.races).to eq([])
    end
  end

  describe "#races && #add_races" do
    before(:each) do
      @presidential = Race.new("Presidential")
      @ny_governor = Race.new("Governor of New York")
      @ny_senator_1 = Race.new("New York Senator #1")
      @ny_senator_2 = Race.new("New York Senator #2")
    end
    it "can add races to the Election" do
      expect(@election.races).to eq([])

      expect(@election.add_race(@presidential)).to eq([@presidential])
      expect(@election.add_race(@ny_governor)).to eq([@presidential, @ny_governor])
      expect(@election.add_race(@ny_senator_1)).to eq([@presidential, @ny_governor, @ny_senator_1])
      expect(@election.add_race(@ny_senator_2)).to eq([@presidential, @ny_governor, @ny_senator_1, @ny_senator_2])
    end
  end

  describe "#candidates" do
    before(:each) do
      @presidential = Race.new("Presidential")
      @ny_governor = Race.new("Governor of New York")
      @ny_senator = Race.new("New York Senator")
      @election.add_race(@presidential)
      @election.add_race(@ny_governor)
      @election.add_race(@ny_senator)
    end

    it "can list every candidate in the election" do
      presidential_candidate_1 = @presidential.register_candidate!({name: "Robert Gunnut", party: :republican})
      presidential_candidate_2 = @presidential.register_candidate!({name: "Andy Leftwich", party: :democrat})
      ny_governor_candidate_1 = @ny_governor.register_candidate!({name: "Bob Loony", party: :republican})
      ny_governor_candidate_2 = @ny_governor.register_candidate!({name: "Common Sense", party: :democrat})
      ny_senator_candidate_1 = @ny_senator.register_candidate!({name: "Joe", party: :republican})
      ny_senator_candidate_2 = @ny_senator.register_candidate!({name: "Michael Callahan", party: :democrat})

      expect(@election.candidates).to eq([presidential_candidate_1, presidential_candidate_2, ny_governor_candidate_1, ny_governor_candidate_2, ny_senator_candidate_1, ny_senator_candidate_2])
    end
  end

  describe "#vote_counts" do
    before(:each) do
      @presidential = Race.new("Presidential")
      @ny_governor = Race.new("Governor of New York")
      @ny_senator = Race.new("New York Senator")
      @election.add_race(@presidential)
      @election.add_race(@ny_governor)
      @election.add_race(@ny_senator)
    end

    it "can list each candidate with their vote counts" do
      presidential_candidate_1 = @presidential.register_candidate!({name: "Robert Gunnut", party: :republican})
      presidential_candidate_2 = @presidential.register_candidate!({name: "Andy Leftwich", party: :democrat})
      ny_governor_candidate_1 = @ny_governor.register_candidate!({name: "Bob Loony", party: :republican})
      ny_governor_candidate_2 = @ny_governor.register_candidate!({name: "Common Sense", party: :democrat})
      ny_senator_candidate_1 = @ny_senator.register_candidate!({name: "Joe", party: :republican})
      ny_senator_candidate_2 = @ny_senator.register_candidate!({name: "Michael Callahan", party: :democrat})

      101.times { presidential_candidate_2.vote_for! }
      2.times { ny_governor_candidate_1.vote_for! }
      56.times { ny_governor_candidate_2.vote_for! }
      4.times { ny_senator_candidate_1.vote_for! }
      87.times { ny_senator_candidate_2.vote_for! }

      expect(@election.vote_counts).to eq({
        "Robert Gunnut" => 0,
        "Andy Leftwich" => 101,
        "Bob Loony" => 2,
        "Common Sense" => 56,
        "Joe" => 4,
        "Michael Callahan" => 87
      })
    end
  end
end