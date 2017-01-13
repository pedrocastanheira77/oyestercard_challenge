require_relative 'journey.rb'

class JourneyLog
  attr_reader :journeys, :journey_class

  def initialize(journey_class = nil)
    @journey_class = journey_class
    @journeys = []
    @journey_hash = {}
  end

  def start(entry_station = nil)
    current_journey if @journey_class == nil
    @journey_hash[:entry_station] = entry_station
  end

  def finish(exit_station = nil)
    @journey_hash[:exit_station] = exit_station
  end

  def log_journey
    @journeys << @journey_hash
    @journey_hash = {}
  end

  private
  def current_journey
    #return "complete" if !!(@journey_hash[:entry_station] && @journey_hash[:exit_station]) == true
    @journey_class = Journey.new
  end
end
