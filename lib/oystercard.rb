class Oystercard
  attr_reader :balance, :entry_station, :journey_list, :exit_station

  MIN_BALANCE = 1
  MIN_FARE = 5
  LIMIT = 90
  

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_list = []
  end
  
  def top_up(value)
    fail "The card limit is £#{LIMIT}" if (@balance + value) > LIMIT
    
    @balance += value
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail 'The minimum balance required to touch in is £1' if @balance < MIN_BALANCE

    @entry_station = station

    'Touched in'
  end

  def touch_out(station)
    deduct
    @exit_station = station
    journey_creator
    @entry_station = nil

    'Touched out'
  end

  def journey_creator
    @journey_list << {entry_station: entry_station, exit_station: exit_station}
  end

  private

  def deduct
    @balance -= MIN_FARE
  end

end