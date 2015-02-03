require 'exceptions'

class Passenger

  attr_writer :credit
  attr_reader :current_station

  def initialize
    @touched_in = false
    @credit = 2
    @current_station = nil
  end

  def board(train, station)
    raise PassengerNotTouchedIn if touched_in? == false
    raise TrainIsFull if train.full?
    train.receive(self, station)
  end

  def alight(train, station)
    train.release(self, station)
  end

  def enter(station)
    raise PassengerAtAnotherStation if @current_station
    station.receive_passenger(self)
    @current_station = station
  end

  def exit(station)
    raise PassengerMustTouchOut if touched_in? == true
    station.release_passenger(self)
    @current_station = nil
  end

  def touch_in
    touch_in_checks
    @touched_in = true
  end

  def add_credit(amount)
    @credit += amount
  end

  def touch_out
    raise PassengerTouchedOut if @touched_in == false
    @credit -= 2
    @touched_in = false
  end

  def touched_in?
    @touched_in
  end

  def credit_check
    @credit
  end

private

  def touch_in_checks
    raise PassengerNotInsideStation unless @current_station
    raise NotEnoughCredit if @credit < 2
    raise PassengerTouchedIn if @touched_in == true
  end

end