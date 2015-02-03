def fill_train(train)
  passenger = Passenger.new
  allow(station).to receive(:receive_passenger)
  passenger.enter(station)
  passenger.touch_in
  allow(station).to receive(:receive_train)
  train.arrive(station)
  train.capacity.times { passenger.board(train, station) }
end

def fill_station(station)
  station.passenger_capacity.times do
    passenger = Passenger.new
    passenger.enter(station)
  end
end

def passenger_arrival_procedure
  allow(station).to receive(:receive_passenger)
  passenger.enter(station)
  passenger.touch_in
end