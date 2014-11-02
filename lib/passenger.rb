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

end