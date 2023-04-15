class Election
  attr_reader :year, :races

  def initialize(year)
    @year = year
    @races = []
  end

  def add_race(race)
    @races << race
  end

  def candidates
    @races.flat_map { |race| race.candidates }
  end

  def vote_counts
    candidates.map { |candidate| [candidate.name, candidate.votes] }.to_h
  end

  def winners
    not_ties = @races.select { |race| !race.tie? }
    not_ties.map { |race| race.winner }
  end
end