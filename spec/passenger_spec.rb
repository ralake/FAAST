require './lib/passenger'
require './lib/train'

describe Passenger do

  let (:passenger) { Passenger.new }
  let (:train) { Train.new }

  it 'must be able to board a train' do
    passenger.board(train)
    expect(train.passenger_count).to eq(1)
  end

  # xit 'must be able to alight a train' do
  # end

  # xit 'cannot board a train if the train is full' do
  # end
  
end