require './lib/station'

describe Station do

  let(:station) { Station.new(4) }

  def fill_station(station)
    passenger = Passenger.new
    station.passenger_capacity.times { passenger.enter(station) }
  end

  it 'should have a default and variable capacity' do
    expect(station.passenger_capacity).to eq(1000)
    station2 = Station.new(4, 2000)
    expect(station2.passenger_capacity).to eq(2000)
  end

  it 'should know when it is full' do
    fill_station(station)
    expect(station).to be_full
  end

  it 'should know when it is empty' do
    expect(station).to be_empty
  end

  it 'should have a default platform capacity' do
    expect(station.platform_capacity).to eq(4)
  end

  it 'should be able to vary the platform capacity on initiallization' do
    station3 = Station.new(10)
    expect(station3.platform_capacity).to eq(10)
  end

  # it 'should not allow more trains to arrive when the platforms are full' do
  # end

  # it 'should not allow a passenger to enter if it is full' do
  # end 
  
end