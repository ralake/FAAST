class Station

  def initialize(platform_capacity = 4, passenger_capacity = 1000)
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
    @platform ||= []
  end

  def receive_passenger(passenger)
    raise StationIsFullError if passengers.count >= passenger_capacity
    passengers << passenger
  end

  def release_passenger(passenger)
    passengers.delete(passenger)
  end

  def receive_train(train)
    raise NoPlatformAvailableError if platforms.count >= platform_capacity
    platforms << train
  end

  def release_train(train)
    platforms.delete(train)
  end
  
end