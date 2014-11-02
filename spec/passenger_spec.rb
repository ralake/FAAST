require './lib/passenger'
require './lib/train'

describe Passenger do

  let(:passenger) { Passenger.new }
  let(:train) { double :train, { :passengers => [] } }
  let(:station) { double :TrainStation, { :passengers => [] } }

  it 'should be able to board a train' do
    expect(train).to receive(:passengers)
    expect(train).to receive(:full?)
    passenger.touch_in
    passenger.board(train)
    expect(train.passengers).to eq([passenger])
  end

  it 'should be able to alight a train' do
    expect(train).to receive(:passengers)
    expect(train).to receive(:full?)
    passenger.touch_in
    passenger.board(train)
    passenger.alight(train)
    expect(train.passengers).to eq ([])
  end

  it 'cannot board a train if the train is full' do
    expect(train).to receive(:full?).and_return(true)
    passenger.touch_in
    expect { passenger.board(train) }.to raise_error(TrainIsFullError)
  end

  it 'should be able to enter a station' do
    expect(station).to receive(:passengers)
    passenger.enter(station)
    expect(station.passengers).to eq([passenger])
  end

  it 'should be able to exit a station' do
    passenger.enter(station)
    passenger.exit(station)
    expect(station.passengers).to eq([])
  end

  it 'should touch in once inside the station' do
    passenger.enter(station)
    passenger.touch_in
    expect(passenger.touched_in?).to be true
  end

  it 'should touch out before leaving the station' do
    passenger.touch_in
    passenger.touch_out
    expect(passenger.touched_in?).to be false
  end

  it 'Should not be initialized as touched in' do
    expect(passenger.touched_in?).to be false
  end

  it 'should not be able to board a train if not touched in' do
    allow(train).to receive(:full?).and_return(false)
    expect { passenger.board(train) }.to raise_error(NotTouchedInError)
  end

  it 'should not be able to leave a station without touching out' do
    passenger.touch_in
    expect { passenger.exit(station) }.to raise_error(MustTouchOutError)
  end
  
end