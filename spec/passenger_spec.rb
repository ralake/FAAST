require './lib/passenger'

describe Passenger do

  let(:passenger) { Passenger.new }
  let(:train) { double :Train, { :passengers => [] } }
  let(:station) { double :TrainStation, { :passengers => [] , :capacity => 1 } }
  let(:station2) { double :Station }

  context "Train interactions" do

    it 'should be able to board a train' do
      allow(train).to receive(:receive)
      allow(train).to receive(:full?)
      passenger.touch_in
      passenger.board(train, station)
    end

    it 'should not be able to board a train if it is full' do
      allow(train).to receive(:receive)
      allow(train).to receive(:full?).and_return true
      expect { passenger.board(train, station) }.to raise_error(RuntimeError)
    end

    it 'should be able to alight a train' do
      allow(train).to receive(:release)
      passenger.alight(train, station)
    end

    it 'should not be able to board a train if not touched in' do
      allow(train).to receive(:full?).and_return(false)
      expect { passenger.board(train, station) }.to raise_error(RuntimeError)
    end

  end

  context "Station interactions" do

    it 'should be able to enter a station' do
      expect(station).to receive(:receive_passenger)
      passenger.enter(station)
    end

    it 'should not be able to enter a station if it is in another station' do
      allow(station).to receive(:receive_passenger)
      allow(station2).to receive(:receive_passenger)
      passenger.enter(station)
      expect(passenger.current_station).to eq(station)
      expect { passenger.enter(station2) }.to raise_error(RuntimeError)
    end

    it 'should be able to exit a station' do
      expect(station).to receive(:release_passenger)
      passenger.exit(station)
    end

    it 'should be able to touch in' do
      passenger.touch_in
      expect(passenger.touched_in?).to be true
    end

    xit 'should not be able to touch in twice in a row' do
    end

    xit 'should not be able to touch in unless inside a station' do
    end

    it 'Should not be initialized as touched in' do
      expect(passenger.touched_in?).to be false
    end

    it 'should be able to touch out' do
      passenger.touch_in
      passenger.touch_out
      expect(passenger.touched_in?).to be false
    end

    xit 'should not be able to touch out twice in a row' do
    end

    it 'should not be able to touch out unless inside the station' do
    end

    it 'should touch out before leaving the station' do
      allow(station).to receive(:receive_passenger)
      passenger.enter(station)
      passenger.touch_in
      expect { passenger.exit(station) }.to raise_error(RuntimeError)
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
      passenger.touch_in
      passenger.touch_out
      expect(passenger.credit_check).to eq(0)
    end

    it 'should not be able to touch in with less that 2GBP' do
      passenger.touch_out
      expect { passenger.touch_in }.to raise_error(RuntimeError)
    end
  end  
end