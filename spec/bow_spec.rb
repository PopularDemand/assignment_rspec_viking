
require 'weapons/bow'

describe Bow do
  let(:bow) { Bow.new }

  context 'default bow configuration' do
    it 'is instantiated with 10 arrows' do
      default_bow = Bow.new
      expect(default_bow.arrows).to eq(10)
    end
  end

  context 'custom bow configuration' do
    it 'is instantiated with given number of arrows' do
      arrows = 1010
      custom_bow = Bow.new(arrows)
      expect(custom_bow.arrows).to eq(arrows)
    end
  end

  describe '#arrows' do

    it 'returns a number greater than or equal to 0' do
      expect(bow.arrows).to be >= 0
    end

  end

  describe "#use" do
    it "decreases arrow count by one" do
      bow.use
      expect(bow.arrows).to eq(9)
    end

    it "throws an error if arrow count is 0" do
      empty_bow = Bow.new(0)
      expect{ empty_bow.use }.to raise_error(RuntimeError) # Should be RuntimeError? or Actual message?
    end
  end

end
