require './lib/station'

describe Station do

  let(:station) { Station.new }

  def fill_station(station)
    passenger = Passenger.new
    station.capacity.times { passenger.enter(station) }
  end

  it 'should have a passenger capacity' do
    expect(station.capacity).to eq(1000)
  end

  it 'should have a variable capacity set by the user' do
    station2 = Station.new(2000)
    expect(station2.capacity).to eq(2000)
  end

  it 'should know when it is full' do
    fill_station(station)
    expect(station).to be_full
  end

  it 'should know when it is empty' do
    expect(station).to be_empty
  end

  # it 'should have a maximum platform capacity' do
  # end

  # it 'should not allow more trains to arrive when the platforms are full' do
  # end

  # it 'should not allow a passenger to enter if it is full' do
  # end 
  
end