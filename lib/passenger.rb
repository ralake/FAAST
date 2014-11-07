class Passenger

  attr_writer :credit
  attr_reader :current_station

  def initialize
    @touched_in = false
    @credit = 2
    @current_station = nil
  end

  def board(train, station)
    raise "The passenger is not touched in." if touched_in? == false
    raise "This train is full." if train.full?
    train.receive(self, station)
  end

  def alight(train, station)
    train.release(self, station)
  end

  def enter(station)
    raise "This passenger is at another station" if !@current_station.nil?
    station.receive_passenger(self)
    @current_station = station
  end

  def exit(station)
    raise "The passenger must touch out before leaving the station." if touched_in? == true
    station.release_passenger(self)
    @current_station = nil
  end

  def touch_in
    touch_in_checks
    @touched_in = true
  end

  def touch_in_checks
    raise "Passenger is not inside a station" if @current_station == nil
    raise "Passenger does not have enough credit. Please add credit."if @credit < 2
    raise "Passenger is already touched in" if @touched_in == true
  end

  def add_credit(amount)
    @credit += amount
  end

  def touch_out
    raise "Passenger is already touched out" if @touched_in == false
    @credit -= 2
    @touched_in = false
  end

  def touched_in?
    @touched_in
  end

  def credit_check
    @credit
  end

end