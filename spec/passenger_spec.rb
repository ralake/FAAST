require './lib/passenger'
require './lib/train'

describe Passenger do

  let(:passenger) { Passenger.new }
  let(:train) { double :train, { :passengers => [] } }
  let(:station) { double :TrainStation, { :passengers => [] } }

  it 'should be able to board a train' do
    expect(train).to receive(:passengers)
    expect(train).to receive(:full?)
    passenger.enter(station)
    passenger.touch_in(station)
    passenger.board(train)
    expect(train.passengers).to eq([passenger])
  end

  it 'should be able to alight a train' do
    expect(train).to receive(:passengers)
    expect(train).to receive(:full?)
    passenger.enter(station)
    passenger.touch_in(station)
    passenger.board(train)
    passenger.alight(train)
    expect(train.passengers).to eq ([])
  end

  it 'cannot board a train if the train is full' do
    expect(train).to receive(:full?).and_return(true)
    passenger.enter(station)
    passenger.touch_in(station)
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
    passenger.touch_in(station)
    expect(passenger.touched_in?).to be true
  end

  it 'should touch out before leaving the station' do
    passenger.enter(station)
    passenger.touch_in(station)
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
    passenger.enter(station)
    passenger.touch_in(station)
    expect { passenger.exit(station) }.to raise_error(MustTouchOutError)
  end

  it 'should not be able to touch in until inside the station' do
    expect { passenger.touch_in(station) }.to raise_error(NotInsideStationError)
  end

  it 'should be initialized with 2GBP credit in its account' do
    expect(passenger.credit_check).to eq(2)
  end

  it 'should be able to add credit to its account' do
    passenger.add_credit(1)
    expect(passenger.credit_check).to eq(3)
  end

  xit 'should have 2GBP credit removed each time it touches out' do
    passenger.touch_out
    expect(passenger.credit_check).to eq()
  end

end