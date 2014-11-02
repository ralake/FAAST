require './lib/passenger'
require './lib/train'

describe Passenger do

  let (:passenger) { Passenger.new }
  let (:train) { double :train, { :passengers => [] } }

  it 'must be able to board a train' do
    expect(train).to receive(:passengers)
    passenger.board(train)
    expect(train.passengers).to eq([passenger])
  end

  it 'must be able to alight a train' do
    expect(train).to receive(:passengers)
    passenger.board(train)
    passenger.alight(train)
    expect(train.passengers).to eq ([])
  end

  # xit 'cannot board a train if the train is full' do
  # end
  
end