class Train

   attr_reader :capacity, :station

  def initialize(number_of_carriages = 2)
    @capacity = number_of_carriages * carriage_capacity
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
    @capacity / carriage_capacity
  end

  def receive(passenger, station)
    raise "This train is full." if full?
    raise "This train is not at the station" unless self.at_station?(station)
    passengers << passenger
    station.passengers.delete(passenger)
  end

  def release(passenger, station)
    raise "The train has not arrived yet" unless self.at_station?(station)
    passengers.delete(passenger)
  end

  def arrive(station)
    raise "This train is at another station" unless @station == nil
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

private
  
  def carriage_capacity(number = 40)
    number.to_i
  end

end