require './lib/train'
require './lib/passenger'

describe Train do

  let(:train) { Train.new }
  let(:train2) { Train.new(2) }
  let(:passenger) { double :passenger }

  def fill_train(train)
    passenger = Passenger.new
    train.capacity.times { passenger.board(train) }
  end

  it 'has a capacity which limits the amount of passengers it can hold' do
    expect(train.capacity).to eq(40)
  end

  it 'can change its capacity depending on the number of carraiages it has' do
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

end