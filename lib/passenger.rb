class Passenger

  def initialize
    @touched_in = false
    @credit = 2
  end

  attr_writer :credit

  def board(train, station)
    raise "The passenger is not touched in." if touched_in? == false
    train.receive(self, station)
    raise "This train is full." if train.full?
  end

  def alight(train)
    train.release(self)
  end

  def enter(station)
    station.receive_passenger(self)
  end

  def exit(station)
    raise "The passenger must touch out before leaving the station." if touched_in? == true
    station.release_passenger(self)
  end

  def touch_in
    raise "The passenger does not have enough credit. Please add credit."if @credit < 2
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