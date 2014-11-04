require './lib/exceptions.rb'

class Passenger

  def initialize
    @touched_in = false
    @credit = 2
  end

  attr_writer :credit

  def board(train)
    raise NotTouchedInError if touched_in? == false
    train.receive(self)
    raise TrainIsFullError if train.full?
  end

  def alight(train)
    train.release(self)
  end

  def enter(station)
    station.receive_passenger(self)
  end

  def exit(station)
    raise MustTouchOutError if touched_in? == true
    station.release_passenger(self)
  end

  def touch_in
    raise NotEnoughCreditError if @credit < 2
    @touched_in = true
  end

  def add_credit(amount)
    @credit += amount
  end

  def touch_out
    @credit -= 2
    @touched_in = false
  end

  def touched_in?
    @touched_in
  end

  def credit_check
    @credit
  end

end