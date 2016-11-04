
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
    let(:string) do
      double("String")
    end

    before(:each) do
      allow(string).to receive(:empty?).and_return(false)
      allow(string).to receive(:upcase!).and_return(string)
      allow(string).to receive(:reverse!)
    end

    it 'calls upcase! on argument string' do
      expect(string).to receive(:upcase!)
      warmup.calls_some_methods(string)
    end

    it 'calls reverse! on argument string' do
      expect(string).to receive(:reverse!)
      warmup.calls_some_methods(string)
    end

    it 'returns unique object' do
      returned_string = warmup.calls_some_methods(string)
      expect(returned_string.object_id).not_to eql(string.object_id)
    end
  end
end
