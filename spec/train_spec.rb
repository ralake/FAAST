require './lib/train'

describe Train do

  let(:train) { Train.new }
  let(:train2) { Train.new(2) }
  let(:passenger) { double :passenger }
  let(:station) { double :station }

  def fill_train(train)
    train.capacity.times { train.receive_passenger(passenger) }
  end

  it 'has a capacity which limits the amount of passengers it can hold' do
    expect(train.capacity).to eq(40)
  end

  it 'can change its capacity depending on the number of carraiages it has' do
    expect(train2.capacity).to eq(80)
  end

  it 'should be able to hold a passenger' do
    train.receive_passenger(passenger)
    expect(train.passenger_count).to eq(1)
  end

  it 'should know when it is full' do
    expect(train).not_to be_full
    fill_train(train)
    expect(train).to be_full
  end

  it 'should not allow more passengers to board if it is full' do
    fill_train(train)
    expect { train.receive_passenger(passenger) }.to raise_error(TrainFullError)
  end

  it 'should allow a passenger to alight the train' do
    train.receive_passenger(passenger)
    train.release_passenger(passenger)
    expect(train.passenger_count).to eq(0)
  end

  it 'should know when it is empty' do
    expect(train.empty?).to be true
    train.receive_passenger(passenger)
    expect(train.empty?).to be false
  end

end