class Journey
  attr_reader :journey_log

  def initialize
    @journey_log = {}
  end

  def start(entry_station = nil)
    @journey_log[:entry_station] = entry_station
  end

  def finish(exit_station = nil)
    @journey_log[:exit_station] = exit_station
  end

  def complete?
    !!(@journey_log[:entry_station] && @journey_log[:exit_station])
  end

  def fare(fare = Oystercard::MIN_LIMIT)
    fare
  end

  def penalty(penalty = 6)
    penalty
  end

end
