class TrainIsFullError < Exception
  def message
    "This train is full"
  end
end

class Passenger

  def initialize
  end

  def board(train)
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

end