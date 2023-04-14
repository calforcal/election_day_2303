class Candidate
  attr_reader :name, :votes, :party

  def initialize(details)
    @name = details[:name]
    @party = details[:party]
    @votes = 0
  end
end