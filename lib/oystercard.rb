require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journeys, :journey

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @balance = 0
    @journey
    @journeys = []
    @touched_in = false
  end

  def top_up(money)
    top_up_attempt = @balance + money
    message = "Limit of #{MAX_LIMIT} exceeded, can not top up the card."
    raise message if top_up_attempt > MAX_LIMIT
    @balance += money
  end

  def in_journey?
    @journey.journey_log[:entry_station] != nil && @journey.journey_log[:exit_station] == nil
  end

  def touch_in(entry_station)
    message = "Insufficient funds. Must top up card."
    raise message if balance < MIN_LIMIT
    touch_in_edgecase if @touched_in == true
    creates_journey(entry_station)
    @touched_in = true
  end

  def touch_out(exit_station)
    touch_out_edgecase if @touched_in == false
    @journey.finish(exit_station)
    deduct(@journey.fare) if @touched_in == true
    journey_printer
    @touched_in = false
  end

  private
  def deduct(money)
    @balance -= money
  end

  def journey_printer
    @journeys << @journey.journey_log
    @journey = nil
  end

  def creates_journey(station)
    @journey = Journey.new
    @journey.start(station)
  end

  def touch_in_edgecase
    @journey.finish
    deduct(@journey.penalty)
    journey_printer
  end

  def touch_out_edgecase
    creates_journey(nil)
    deduct(@journey.penalty)
  end
end
