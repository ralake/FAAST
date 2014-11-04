require './lib/passenger'

describe Passenger do

  let(:passenger) { Passenger.new }
  let(:train) { double :train, { :passengers => [] } }
  let(:station) { double :TrainStation, { :passengers => [] , :capacity => 1 } }

  context "Train interactions" do

    it 'should be able to board a train' do
      allow(train).to receive(:receive)
      allow(train).to receive(:full?)
      passenger.touch_in
      passenger.board(train)
    end

    it 'should be able to alight a train' do
      expect(train).to receive(:release)
      passenger.alight(train)
    end

    it 'cannot board a train if the train is full' do
      allow(train).to receive(:full?).and_return(:true)
      allow(train).to receive(:receive)
      passenger.touch_in
      expect { passenger.board(train) }.to raise_error(RuntimeError)
    end

    it 'should not be able to board a train if not touched in' do
      allow(train).to receive(:full?).and_return(false)
      expect { passenger.board(train) }.to raise_error(RuntimeError)
    end

  end

  context "Station interactions" do

    it 'should be able to enter a station' do
      expect(station).to receive(:receive_passenger)
      passenger.enter(station)
    end

    it 'should be able to exit a station' do
      expect(station).to receive(:release_passenger)
      passenger.exit(station)
    end

    it 'should be able to touch in' do
      passenger.touch_in
      expect(passenger.touched_in?).to be true
    end

    it 'should be able to touch out' do
      passenger.touch_in
      passenger.touch_out
      expect(passenger.touched_in?).to be false
    end

    it 'should touch out before leaving the station' do
      expect(station).to receive(:receive_passenger)
      passenger.enter(station)
      passenger.touch_in
      expect { passenger.exit(station) }.to raise_error(RuntimeError)
    end

    it 'Should not be initialized as touched in' do
      expect(passenger.touched_in?).to be false
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