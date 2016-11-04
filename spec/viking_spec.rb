
require 'viking'

describe Viking do
  let(:default_viking) { Viking.new }
  before { allow(STDOUT).to receive(:puts) }

  describe '#initialize' do
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
      it 'is instantiated without a weapon' do
        expect(default_viking.weapon).to be nil
      end
    end
  end

  describe '#health=' do
    it 'cannot have health manually altered after initialization' do
      expect{ default_viking.health = 6000 }.to raise_error(NoMethodError)
    end
  end

  describe '#pick_up_weapon' do
    it 'raises an error unless argument is a weapon' do
      harmless = double
      expect { default_viking.pick_up_weapon(harmless) }.to raise_error(RuntimeError)
    end

    context 'passed valid argument' do
      let(:weapon) { double }
      #let(:weapon, :other_weapon) { double, double }
      #let(:weapon, :other_weapon) { [double, double] }
      before(:each) do
        allow(weapon).to receive(:is_a?).with(Weapon).and_return(true)
      end

      it 'sets vikings weapon to argument' do
        default_viking.pick_up_weapon(weapon)
        expect(default_viking.weapon).to eq(weapon)
      end

      it 'replaces vikings weapon with argument' do
        default_viking.pick_up_weapon(weapon)
        other_weapon = double
        allow(other_weapon).to receive(:is_a?).with(Weapon).and_return(true)
        default_viking.pick_up_weapon(other_weapon)
        expect(default_viking.weapon).to eq(other_weapon)
      end
    end
  end

  describe '#drop_weapon' do
    it 'sets the vikings weapon to nothing' do
      weapon = "axe"
      viking_with_weapon = Viking.new("", 10, 10, weapon)
      viking_with_weapon.drop_weapon
      expect(viking_with_weapon.weapon).to be nil
    end
  end

  describe "#receive_attack" do
    it 'reduces viking\'s health by given amount' do
      damage = 3
      starting_health = default_viking.health
      default_viking.receive_attack(damage)
      expect(default_viking.health).to eq(starting_health - damage)
    end

    it 'calls the take damage method on the viking' do
      expect(default_viking).to receive(:take_damage).with(3)
      default_viking.receive_attack(3)
    end
  end

  describe "#attack" do
    let(:target_viking) { Viking.new }
    let(:damage) { 1 }

    it 'reduces the targets health by some number' do
      allow(default_viking).to receive(:damage_dealt).and_return(damage)
      starting_health = target_viking.health
      default_viking.attack(target_viking)
      expect(target_viking.health).to eq(starting_health - damage)
    end

    it 'calls the #take_damage method on the target' do
      allow(default_viking).to receive(:damage_dealt).and_return(damage)
      expect(target_viking).to receive(:take_damage).with(damage)
      default_viking.attack(target_viking)
    end

    it 'runs #damage_with_fist if viking has no weapon' do
      expect(default_viking).to receive(:damage_with_fists).and_return(damage)
      default_viking.attack(target_viking)
    end

    it "attacking with no weapon deals Fists multiplier times strength damage" do
      expect(target_viking).to receive(:take_damage).with(2.5)
      default_viking.attack(target_viking)
    end

  end

end
