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
    @oyster_account.finish(station)
    deduct(@oyster_account.fare) if @touched_in == true
    @oyster_account.log_journey
    @touched_in = false
  end

  private
  def deduct(money)
    @balance -= money
  end

  def creates_journey(station)
    @oyster_account.start(station)
  end

  def touch_in_edgecase
    deduct(@oyster_account.penalty)
    @oyster_account.finish
    @oyster_account.log_journey
  end

  def touch_out_edgecase
    creates_journey(nil)
    deduct(@oyster_account.penalty)
  end
end
