class Train

  def initialize(number_of_carriages = 1)
    @capacity = number_of_carriages.to_i * carriage_capacity
  end

  def passengers
    @passengers ||= []
  end

  attr_reader :capacity

  def carriage_capacity(number = 40)
    number.to_i
  end

  def receive(passenger)
    passengers << passenger
  end

  def passenger_count
    passengers.count
  end

  def full?
    passenger_count >= @capacity
  end

end