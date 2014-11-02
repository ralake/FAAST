require './lib/train'
require './lib/passenger'

describe Train do

  let(:train) { Train.new }
  let(:passenger) { double :passenger }            
  let(:station) { double :train_station }

  def fill_train(train)
    passenger = Passenger.new
    passenger.touch_in
    train.capacity.times { passenger.board(train) }
  end

  it 'has a capacity which limits the amount of passengers it can hold' do
    expect(train.capacity).to eq(40)
  end

  it 'can change its capacity depending on the number of carraiages it has' do
    train2 = Train.new(2)
    expect(train2.capacity).to eq(80)
  end

  it 'should know when it is full' do
    expect(train).not_to be_full
    fill_train(train)
    expect(train).to be_full
  end

  it 'should know when it is empty' do
    expect(train.empty?).to be true
  end

  it 'should be able to arrive at a station' do
    expect(station). to receive(:train_count).and_return(1)
    expect(station).to receive(:platforms).and_return([train])
    train.arrive(station)
    expect(station.train_count).to eq(1)
  end

  it 'should be able to depart from a station' do
    expect(station).to receive(:train_count).and_return(1, 0)
    expect(station).to receive(:platforms).and_return([])
    expect(station.train_count).to eq(1)
    train.depart(station)
    expect(station.train_count).to eq(0)
  end

end