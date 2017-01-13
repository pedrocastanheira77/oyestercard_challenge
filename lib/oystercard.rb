require_relative 'journey'
require_relative 'station'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance, :journey, :oyster_account

  MAX_LIMIT = 90
  MIN_LIMIT = 1

  def initialize
    @oyster_account = JourneyLog.new
    @balance = 0
    @journey
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

  def touch_in(station)
    message = "Insufficient funds. Must top up card."
    raise message if balance < MIN_LIMIT
    touch_in_edgecase if @touched_in == true
    creates_journey(station)
    @touched_in = true
  end

  def touch_out(station)
    touch_out_edgecase if @touched_in == false
    @journey.exit_station = station
    deduct(@journey.fare) if @touched_in == true
    @oyster_account.finish(station)
    @oyster_account.log
    @touched_in = false
  end

  private
  def deduct(money)
    @balance -= money
  end

  def journey_printer
    @oyster_account.log
  end

  def creates_journey(entry_station)
    @journey = Journey.new
    @journey.entry_station = entry_station
    @oyster_account.start(entry_station)
  end

  def touch_in_edgecase
    deduct(@journey.penalty)
    @oyster_account.finish
    @oyster_account.log
  end

  def touch_out_edgecase
    creates_journey(nil)
    deduct(@journey.penalty)
  end
end
