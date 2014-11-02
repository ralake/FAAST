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

  # xit 'should know when it is empty' do
  # end

  # xit 'should not allow more passengers to enter when it is full' do
  # end

  # xit 'should have a maximum platform capacity' do
  # end

  # xit 'should not allow more trains to arrive when the platforms are full' do
  # end
  
end