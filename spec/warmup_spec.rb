
require 'warmup'

describe Warmup do
  let(:warmup) { Warmup.new }
  before { allow(STDOUT).to receive(:puts) }

  describe '#gets_shout' do
    before(:each) do
      allow(warmup).to receive(:gets).and_return("string\n")
    end

    it 'puts shout to stdout' do
      expect{ warmup.gets_shout }.to output(/^S.+/).to_stdout
    end

    it 'gets input from stdin, removes trailing whitespace, and upcases it' do
      expect(warmup.gets_shout).to eq("STRING")
    end

  end

  describe '#triple_size' do

    it 'returns an integer that is three times the length of the argument array' do
      array = double(size: 8)
      expect(warmup.triple_size(array)).to eq(24)
    end
  end


  describe '#calls_some_methods' do
    let(:string) { double }

    it 'calls upcase! on argument string'

    it 'calls reverse! on argument string'

    it 'returns unique object'
  end
end
