class Race
  attr_reader :office, :candidates

  def initialize(office)
    @office = office
    @candidates = []
  end

  def register_candidate!(details)
    @candidates << candidate = Candidate.new(details)
    candidate
  end
end