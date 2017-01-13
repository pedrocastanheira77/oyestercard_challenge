require_relative 'journey.rb'

class JourneyLog
  attr_reader :journeys

  def initialize
    @journeys = []
    @journey = {}
  end

  def start(entry_station = nil)
    @journey[:entry_station] = entry_station
  end

  def finish(exit_station = nil)
    @journey[:exit_station] = exit_station
  end

  def log
    @journeys << @journey
    @journey = {}
  end

  private
  # def current_journey
  #     !!(@journey_log[:entry_station] && @journey_log[:exit_station])
  # end
end
