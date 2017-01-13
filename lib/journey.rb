class Journey
  attr_accessor :entry_station, :exit_station

  PENALTY = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  # def start(entry_station = nil)
  #   @entry_station
  # end
  #
  # def finish(exit_station = nil)
  #   @exit_station
  # end

  def fare(fare = Oystercard::MIN_LIMIT)
    fare
  end

  def penalty(penalty = PENALTY)
    penalty
  end

end
