
require 'viking'

describe Viking do
  let(:default_viking) { Viking.new }

  context 'viking configuration' do
    describe 'custom configuration' do
      it 'can be instantiated with a given name' do
        name = 'Sven'
        sven = Viking.new(name)
        expect(sven.name).to eq(name)
      end

      it 'can be instantiated with a given health' do
        health = 6000
        sven = Viking.new("", health)
        expect(sven.health).to eq(health)
      end
    end

    describe 'default configuration' do

    end
  end

  context 'in general' do
    it 'cannot have health manually altered after initialization' do

      expect{ default_viking.health = 6000 }.to raise_error(NoMethodError)
    end

  end
end