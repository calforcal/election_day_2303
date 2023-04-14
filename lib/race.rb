class Race
  attr_reader :office, :candidates

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
end