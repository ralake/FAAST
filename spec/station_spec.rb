require './lib/station'
require 'helpers'

describe Station do

  let(:station)   { Station.new }
  let(:passenger) { double :passenger }
  let(:train)     { double :train }

  context "Passenger interactions" do
  
    it 'should have a default and variable passenger capacity' do
      expect(station.passenger_capacity).to eq(1000)
    end

    it 'should be able to set a capacity on initializing' do
      station_two = Station.new(4, 2000) 
      expect(station_two.passenger_capacity).to eq(2000)
    end

    it 'should receive passengers' do
      expect {station.receive_passenger(passenger)}.to change { station.passengers }
    end

    it 'should not receive a passenger if they are already at the station' do
      station.receive_passenger(passenger)
      expect { station.receive_passenger(passenger) }.to raise_error(PassengerAlreadyAtStation)
    end

    it 'should know when it is full of passengers' do
      fill_station(station)
      expect(station).to be_full
    end

    it 'should not allow a passenger to enter if it is full' do
      fill_station(station)
      expect { station.receive_passenger(passenger) }.to raise_error(StationIsFull)
    end 

    it 'should release passengers' do
      station.receive_passenger(passenger)
      station.release_passenger(passenger)
      expect(station.passengers.count).to eq(0)
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
      station_three = Station.new(10)
      expect(station_three.platform_capacity).to eq(10)
    end

    it 'should not allow more trains to arrive when the platforms are full' do
      station.platform_capacity.times { station.receive_train(train) }
      expect { station.receive_train(train) }.to raise_error(NoPlatformsAvailable)
    end

  end

end