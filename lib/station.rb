class Station

  def initialize(platform_capacity, passenger_capacity = 1000)
    @passenger_capacity = passenger_capacity
    @platform_capacity = platform_capacity
  end

  attr_reader :passenger_capacity
  attr_reader :platform_capacity

  def full?
    passengers.count >= @passenger_capacity
  end

  def empty?
    passengers.count == 0
  end

  def passengers
    @passengers ||= []
  end

  def platforms
    @platforms ||= []
  end

end