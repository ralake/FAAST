require './lib/train'

describe Train do

  let(:train) { Train.new }
  let(:train2) { Train.new(2) }

  it 'has a capacity which limits the amount of passengers it can hold' do
    expect(train.capacity).to eq(40)
  end

  it 'can change its capacity depending on the number of carraiages it has' do
    expect(train2.capacity).to eq(80)
  end
  
end