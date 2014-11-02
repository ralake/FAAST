require './lib/train'

describe Train do

  let(:train) { Train.new }

  it 'has a capacity which limits the amount of passengers it can hold' do
    expect(train.capacity).to eq(40)
  end
  
end