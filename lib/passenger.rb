class Passenger

  def initialize
  end

  def board(train)
    train.passengers << self
  end

  def alight(train)
    train.passengers.delete(self)  
  end

end