require "spec_helper"

describe Cell do
  describe "#live?" do
    it "returns true by default cell is live" do
      expect(Cell.new.live?).to be_true
    end

    it "returns false" do
      expect(Cell.new(live: false).live?).to be_false
    end

    it "returns true" do
      expect(Cell.new(live: true).live?).to be_true
    end
  end

  describe "#live" do
    it 'returns true upon give live to live' do
      expect(Cell.new.live.live?).to be_true
    end

    it 'returns false upon give live to dead cell' do
      cell = Cell.new(live: false)
      expect(cell.live?).to be_false
      expect(cell.live.live?).to be_true
    end

    it 'returns true upon give live to live cell' do
      cell = Cell.new(live: true)
      expect(cell.live?).to be_true
      expect(cell.live.live?).to be_true
    end
  end

  describe "#die" do
    it 'returns false upon give dead to live cell' do
      expect(Cell.new.die.live?).to be_false
    end

    it 'returns false upon give dead to dead cell' do
      cell = Cell.new(live: false)
      expect(cell.live?).to be_false
      expect(cell.die.live?).to be_false
    end

    it 'returns false upon give dead to live cell' do
      cell = Cell.new(live: true)
      expect(cell.live?).to be_true
      expect(cell.die.live?).to be_false
    end
  end
end