# require './lib/exceptions'

class Train

  def initialize(number_of_carriages = 2)
    @capacity = number_of_carriages * carriage_capacity
  end

  def passengers
    @passengers ||= []
  end

  attr_reader :capacity

  def carriage_capacity(number = 40)
    number.to_i
  end

  def full?
    passengers.count >= @capacity
  end

  def empty?
    passengers.count == 0
  end

  def receive(passenger)
    raise TrainIsFullError if full?
    passengers << passenger
  end

  def release(passenger)
    passengers.delete(passenger)
  end

  def arrive(station)
    station.receive_train(self)
  end

  def depart(station)
    station.release_train(self)
  end

end