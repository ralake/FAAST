class TrainIsFullError < Exception
  def message
    "This train is full"
  end
end

class NotTouchedInError < Exception
  def message
    "This passenger needs to touch in before boarding the train"
  end
end

class MustTouchOutError < Exception
  def message
    "Passenger must touch out before leaving the station"
  end
end

class Passenger

  def initialize
    touch_out
    @credit = 0
  end

  attr_writer :credit

  def board(train)
    raise NotTouchedInError if touched_in? == false
    raise TrainIsFullError if train.full?
    train.passengers << self
  end

  def alight(train)
    train.passengers.delete(self)  
  end

  def enter(station)
    station.passengers << self
  end

  def exit(station)
    raise MustTouchOutError if touched_in? == true
    station.passengers.delete(self)
  end

  def touch_in
    @status = true
  end

  def touch_out
    @status = false
  end

  def touched_in?
    @status
  end

  def credit
    @credit
  end

end