class Passenger

  def initialize
  end

  def board(train)
    train.passengers << self
  end

end