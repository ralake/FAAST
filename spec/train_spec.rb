require './lib/train'

describe Train do

  let(:train) { Train.new }
  let(:passenger) { double :passenger }            
  let(:station) { double :train_station,  :passengers => []  }
  let(:station2) { double :train_station }

  def fill_train(train)
    passenger = Passenger.new
    passenger.touch_in
    train.capacity.times { passenger.board(train, station) }
  end

  context "Passenger interactions" do

    it 'has a passenger capacity' do
      expect(train.capacity).to eq(80)
    end

    it 'can change its capacity depending on the number of carraiages it has' do
      train2 = Train.new(3)
      expect(train2.capacity).to eq(120)
    end

    it 'should know when it is full' do
      allow(station).to receive(:platforms).and_return([])
      expect { fill_train(train) }.to raise_error(RuntimeError)
    end

    it 'should know when it is empty' do
      expect(train.empty?).to be true
    end

    it 'should receive passengers' do
      allow(station).to receive(:platforms).and_return([train])
      expect { train.receive(passenger, station) }.to change { train.passengers }
    end

    it 'should only allow passengers to board if it is at a station' do
      allow(station).to receive(:platforms).and_return([])
      expect { train.receive(passenger, station) }.to raise_error(RuntimeError)
    end

    it 'should release passengers' do
      allow(station).to receive(:platforms).and_return([train])
      train.receive(passenger, station)
      train.release(passenger, station)
      expect(train.passengers.count).to eq(0)
    end

    it 'should not allow passengers to alight if it is not at a station' do
      allow(station).to receive(:platforms).and_return([])
      expect { train.release(passenger, station) }.to raise_error(RuntimeError)
    end

  end

  context "Station interactions" do

    it 'should be able to arrive at a station' do
      expect(station).to receive(:receive_train)
      train.arrive(station)
    end

    it 'should not be able to arrive at the next station if it has not departed the current station' do
      allow(station).to receive(:receive_train)
      allow(station2).to receive(:receive_train)
      train.arrive(station)
      expect { train.arrive(station2) }.to raise_error(RuntimeError)
    end

    it 'should not be able to arrive at the same station twice' do
      allow(station).to receive(:receive_train)
      allow(station2).to receive(:receive_train)
      train.arrive(station)
      expect { train.arrive(station) }.to raise_error(RuntimeError)
    end

    it 'should be able to depart from a station' do
      expect(station).to receive(:release_train)   
      train.depart(station)
    end

  end

end