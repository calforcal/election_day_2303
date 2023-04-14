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

  # def tie?
  #   return false if open?

  #   most_votes = 0
  #   count = 0
  #   winner = nil
  #   @candidates.each do |candidate|
  #     if candidate.votes > most_votes
  #       winner = candidate
  #     end
  #   end
  #   @candidates.each do |candidate|
  #     if candidate.votes == most_votes
  #       count += 1
  #     end
  #     count
  #   end
  #   if count > 1 then return true else return false end
  # end
end