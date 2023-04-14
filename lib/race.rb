class Race
  attr_reader :office, :candidates, :is_open

  def initialize(office)
    @office = office
    @candidates = []
    @is_open = true
  end

  def register_candidate!(details)
    @candidates << candidate = Candidate.new(details)
    candidate
  end

  def open?
    @is_open
  end

  def close!
    @is_open = false
  end

  def winner
    return false if open?

    most_votes = 0
    winner = nil
    @candidates.each { |candidate| if candidate.votes > most_votes then winner = candidate else end}
    winner
  end
end