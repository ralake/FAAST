require './lib/passenger'
require './lib/train'

describe Passenger do

  let(:passenger) { Passenger.new }
  let(:train) { double :train, { :passengers => [] } }
  let(:station) { double :TrainStation, { :passengers => [] } }

  it 'must be able to board a train' do
    expect(train).to receive(:passengers)
    expect(train).to receive(:full?)
    passenger.board(train)
    expect(train.passengers).to eq([passenger])
  end

  it 'must be able to alight a train' do
    expect(train).to receive(:passengers)
    expect(train).to receive(:full?)
    passenger.board(train)
    passenger.alight(train)
    expect(train.passengers).to eq ([])
  end

  it 'cannot board a train if the train is full' do
    expect(train).to receive(:full?).and_return(true)
    expect { passenger.board(train) }.to raise_error(TrainIsFullError)
  end

  it 'must be able to enter a station' do
    expect(station).to receive(:passengers)
    passenger.enter(station)
    expect(station.passengers).to eq([passenger])
  end

  it 'must be able to exit a station' do
    passenger.enter(station)
    passenger.exit(station)
    expect(station.passengers).to eq([])
  end
  
end