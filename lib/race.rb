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
    @candidates.max_by { |candidate| candidate.votes }
  end

  def tie?
    return false if open?

    count = @candidates.count { |candidate| winner.votes == candidate.votes }

    if count > 1 then return true else return false end
  end
end