require 'exceptions'

class Station

  def initialize(platform_capacity = 4, passenger_capacity = 1000)
    @passenger_capacity = passenger_capacity
    @platform_capacity = platform_capacity
  end

  attr_reader :passenger_capacity, :platform_capacity

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

  def receive_passenger(passenger)
    raise PassengerAlreadyAtStation if passengers.include?(passenger)
    raise StationIsFull if passengers.count >= passenger_capacity
    passengers << passenger
  end

  def release_passenger(passenger)
    passengers.delete(passenger)
  end

  def receive_train(train)
    raise NoPlatformsAvailable if platforms.count >= platform_capacity
    platforms << train
  end

  def release_train(train)
    platforms.delete(train)
  end
  
end