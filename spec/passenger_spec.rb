require './lib/passenger'
require 'helpers'

describe Passenger do

  let(:passenger) { Passenger.new }
  let(:train)     { double :Train, passengers: [] }
  let(:station)   { double :TrainStation, passengers: [] , capacity: 1 }
  let(:station2)  { double :Station }

  before do
    allow(station).to receive(:receive_passenger)
  end

  context "Train interactions" do

    before :each do
      allow(train).to receive(:receive)
    end

    it 'should be able to board a train' do
      expect(station).to receive(:receive_passenger)
      passenger_arrival_procedure
      allow(train).to receive(:full?)
      passenger.board(train, station)
    end

    it 'should not be able to board a train if it is full' do
      allow(train).to receive(:full?).and_return true
      passenger_arrival_procedure
      expect { passenger.board(train, station) }.to raise_error(TrainIsFull)
    end

    it 'should be able to alight a train' do
      allow(train).to receive(:release)
      passenger.alight(train, station)
    end

    it 'should not be able to board a train if not touched in' do
      allow(train).to receive(:full?).and_return(false)
      expect { passenger.board(train, station) }.to raise_error(PassengerNotTouchedIn)
    end

  end

  context "Station interactions" do

    it 'should be able to enter a station' do
      passenger.enter(station)
    end

    it 'should not be able to enter a station if it is in another station' do
      allow(station2).to receive(:receive_passenger)
      passenger.enter(station)
      expect { passenger.enter(station2) }.to raise_error(PassengerAtAnotherStation)
    end

    it 'should be able to exit a station' do
      expect(station).to receive(:release_passenger)
      passenger.exit(station)
    end

    it 'should be able to touch in' do
      passenger_arrival_procedure
      expect(passenger.touched_in?).to be true
    end

    it 'should not be able to touch in twice in a row' do
      passenger_arrival_procedure
      expect { passenger.touch_in }.to raise_error(PassengerTouchedIn)
    end

    it 'should not be able to touch in unless inside a station' do
      expect { passenger.touch_in }.to raise_error(PassengerNotInsideStation)
    end

    it 'Should not be initialized as touched in' do
      expect(passenger.touched_in?).to be false
    end

    it 'should be able to touch out' do
      passenger_arrival_procedure
      passenger.touch_out
      expect(passenger.touched_in?).to be false
    end

    it 'should not be able to touch out twice in a row' do
      passenger_arrival_procedure
      passenger.touch_out
      expect { passenger.touch_out }.to raise_error(PassengerTouchedOut)
    end

    it 'should not be able to touch out unless inside the station' do
      expect { passenger.touch_out }.to raise_error(PassengerTouchedOut)
    end

    it 'should touch out before leaving the station' do
      passenger_arrival_procedure
      expect { passenger.exit(station) }.to raise_error(PassengerMustTouchOut)
    end

  end

  context "Credit" do

    it 'should be initialized with 2GBP credit in its account' do
      expect(passenger.credit_check).to eq(2)
    end

    it 'should be able to add credit to its account' do
      passenger.add_credit(1)
      expect(passenger.credit_check).to eq(3)
    end

    it 'should have 2GBP credit removed each time it touches out' do
      passenger_arrival_procedure
      passenger.touch_out
      expect(passenger.credit_check).to eq(0)
    end

    it 'should not be able to touch in with less that 2GBP' do
      passenger_arrival_procedure
      passenger.touch_out
      expect { passenger.touch_in }.to raise_error(NotEnoughCredit)
    end

  end  

end