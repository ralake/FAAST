class Station

  def initialize(number = 1000)
    @capacity = number
  end

  attr_reader :capacity

  def full?
    passengers.count >= @capacity
  end

  def passengers
    @passengers ||= []
  end

end