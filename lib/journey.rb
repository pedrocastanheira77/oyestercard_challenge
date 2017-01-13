class Journey
  attr_accessor :entry_station, :exit_station, :fare, :penalty

  PENALTY = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def fare(fare = Oystercard::MIN_LIMIT)
    @fare = fare
  end

  def penalty(penalty = PENALTY)
    @penalty = penalty
  end

end
