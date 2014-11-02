class Station

  def initialize(passenger_capacity = 1000)
    @passenger_capacity = passenger_capacity
  end

  attr_reader :passenger_capacity
  attr_reader :platform_capactiy

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

  def platform_capacity(number = 4)
    @platform_capacity = number
  end
  
end