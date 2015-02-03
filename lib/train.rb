require 'exceptions'

class Train

  attr_reader :capacity, :station

  CARRIAGE_CAPACITY = 40

  def initialize(number_of_carriages = 2)
    @capacity = number_of_carriages * CARRIAGE_CAPACITY
    @station = nil
  end

  def passengers
    @passengers ||= []
  end

  def full?
    passengers.count >= @capacity
  end

  def empty?
    passengers.count == 0
  end

  def carriage_count
    @capacity / CARRIAGE_CAPACITY
  end

  def receive(passenger, station)
    raise TrainIsFull if full?
    raise TrainNotAtStation unless at_station?(station)
    passengers << passenger
    station.release_passenger(passenger)
  end

  def release(passenger, station)
    raise TrainNotArrived unless at_station?(station)
    passengers.delete(passenger)
  end

  def arrive(station)
    raise TrainAtAnotherStation if @station
    @station = station 
    station.receive_train(self)
  end

  def depart(station)
    station.release_train(self)
    @station = nil
  end

  def at_station?(station)
    station.platforms.include?(self)
  end

end