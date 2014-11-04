require './lib/train'
require './lib/passenger'

describe Train do

  let(:train) { Train.new }
  let(:passenger) { double :passenger }            
  let(:station) { double :train_station, { :passengers => []} }

  def fill_train(train)
    passenger = Passenger.new
    passenger.touch_in
    train.capacity.times { passenger.board(train) }
  end

  it 'has a capacity which limits the amount of passengers it can hold' do
    expect(train.capacity).to eq(80)
  end

  it 'can change its capacity depending on the number of carraiages it has' do
    train2 = Train.new(3)
    expect(train2.capacity).to eq(120)
  end

  it 'should know when it is full' do
    expect { fill_train(train) }.to raise_error(TrainIsFullError)
  end

  it 'should know when it is empty' do
    expect(train.empty?).to be true
  end

  it 'should receive passengers' do
    expect { train.receive(passenger) }.to change { train.passengers }
  end

  it 'should release passengers' do
    train.receive(passenger)
    train.release(passenger)
    expect(train.passengers.count).to eq(0)
  end

  it 'should be able to arrive at a station' do
    expect(station).to receive(:receive_train)
    train.arrive(station)
  end

  it 'should be able to depart from a station' do
    expect(station).to receive(:release_train)   
    train.depart(station)
  end

end