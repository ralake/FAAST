class TrainFullError < Exception
  def message
    "No more room on the train"
  end
end

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

  def receive_passenger(passenger)
    raise TrainFullError if full?
    passengers << passenger
  end

  def release_passenger(passenger)
    passengers.delete(passenger)
  end

  def passenger_count
    passengers.count
  end

  def full?
    passenger_count >= @capacity
  end

  def empty?
    passenger_count == 0
  end

end