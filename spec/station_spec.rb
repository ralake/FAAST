require './lib/station'

describe Station do

  let(:station) { Station.new }
  let(:passenger) { double :passenger }
  let(:train) { double :train }

  def fill_station(station)
    passenger = Passenger.new
    station.passenger_capacity.times { passenger.enter(station) }
  end

  context "Passenger interactions" do
  
    it 'should have a default and variable passenger capacity' do
      expect(station.passenger_capacity).to eq(1000)
      station2 = Station.new(4, 2000)
      expect(station2.passenger_capacity).to eq(2000)
    end

    it 'should receive passengers' do
      expect {station.receive_passenger(passenger)}.to change { station.passengers }
    end

     it 'should release passengers' do
      station.receive_passenger(passenger)
      station.release_passenger(passenger)
      expect(station.passengers.count).to eq(0)
    end

    it 'should know when it is full of passengers' do
      fill_station(station)
      expect(station).to be_full
    end

    it 'should not allow a passenger to enter if it is full' do
      fill_station(station)
      expect { station.receive_passenger(passenger) }.to raise_error(RuntimeError)
    end 

    it 'should know when there are no passengers inside' do
      expect(station).to be_empty
    end

  end

  context "Train interactions" do

    it 'should have a default platform capacity' do
      expect(station.platform_capacity).to eq(4)
    end

    it 'should receive a train' do
      expect { station.receive_train(train) }.to change { station.platforms }
    end

    it 'should release a train' do
      station.receive_train(train)
      station.release_train(train)
      expect(station.platforms).to eq([])
    end

    it 'should be able to vary the platform capacity on initiallization' do
      station3 = Station.new(10)
      expect(station3.platform_capacity).to eq(10)
    end

    it 'should not allow more trains to arrive when the platforms are full' do
      station.platform_capacity.times { station.receive_train(train) }
      expect { station.receive_train(train) }.to raise_error(RuntimeError)
    end

  end

end