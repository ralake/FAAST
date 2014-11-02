require './lib/train'

describe Train do

  let(:train) { Train.new }
  let(:train2) { Train.new(2) }
  let(:passenger) { double :passenger }
  let(:p2) { double :passenger }

  it 'has a capacity which limits the amount of passengers it can hold' do
    expect(train.capacity).to eq(40)
  end

  it 'can change its capacity depending on the number of carraiages it has' do
    expect(train2.capacity).to eq(80)
  end

  it 'should be able to hold a passenger' do
    train.receive(passenger)
    expect(train.passenger_count).to eq(1)
  end


end