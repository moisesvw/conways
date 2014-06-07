require "spec_helper"

describe Grid do
  let(:cell) { double('Cell') }
  let(:custome_grid) { 
    [
      [  1,  2,  3,  4,  5,  6,  7, 8  ],
      [  9, 10, 11, 12, 13, 14, 15, 16 ],
      [ 17, 18, 19, 20, 21, 22, 23, 24 ],
      [ 25, 26, 27, 28, 29, 30, 31, 32 ],
      [ 33, 34, 35, 36, 37, 38, 39, 40 ],
      [ 41, 42, 43, 44, 45, 46, 47, 48 ],
      [ 49, 50, 51, 52, 53, 54, 55, 56 ],
      [ 57, 58, 59, 60, 61, 62, 63, 64 ]
    ]
  }

  describe "#table" do
    it "returns default grid" do
      expected = Array.new(8).map { |row| row = Array.new(8) }
      grid = Grid.new
      expect(grid.table).to match_array(expected)
    end
    
    it "returns custom grid" do
      grid = Grid.new(custome_grid)
      expect(grid.table).to match_array(custome_grid)
    end
  end

  describe "#neighbors" do
    subject { Grid.new(custome_grid) }

    it "returns cell's neighbors" do
      expected = [28, 29, 30, 36, 38, 44, 45, 46]
      expect(subject.neighbors(4,4)).to match_array(expected)
    end

    it "returns corner cell's neighbors" do
      expected = [49, 50, 58]
      expect(subject.neighbors(7, 0)).to match_array(expected)
    end
  end

  describe "#live_neighbors" do
    let(:n1) { double('one', live?: false) }
    let(:n2) { double('two', live?: false) }
    let(:n3) { double('three', live?: true) }
    let(:n4) { double('four', live?: true) }

    it "returns live neighbors" do
      neighbors = [n1, n2, n3, n4]
      expect(Grid.new.live_neighbors(neighbors)).to match_array([n3, n4])
    end

    it "returns empty when no neighbors live" do
      expect(Grid.new.live_neighbors([n1, n2])).to match_array([])
    end

    it "returns all neighbors when they live" do
      expect(Grid.new.live_neighbors([n3, n4])).to match_array([n3, n4])
    end

    it "returns empty when none neighbors" do
      expect(Grid.new.live_neighbors([])).to match_array([])
    end
  end

  describe "#under_population?" do
    it "returns true when has less than two neighbors" do
      grid = Grid.new
      expect(grid).to receive(:live_neighbors) { [:one] }
      expect(grid.under_population?(cell)).to be_true
    end

    it "returns false when has two or more neighbors" do
      grid = Grid.new
      expect(grid).to receive(:live_neighbors) { [:one, :two] }
      expect(grid.under_population?).to be_false
      expect(grid).to receive(:live_neighbors) { [:one, :two, :three] }
      expect(grid.under_population?).to be_false
    end
  end

  describe "#stable?" do
    it "returns true when has between two and three neighbors" do
      grid = Grid.new
      expect(grid).to receive(:live_neighbors) { [:one, :two] }
      expect(grid.under_population?).to be_true
      expect(grid).to receive(:live_neighbors) { [:one, :two, :three] }
      expect(grid.under_population?).to be_true
    end

    it "returns false when has less than two or more than three neighbors" do
      grid = Grid.new
      expect(grid).to receive(:live_neighbors) { [:one] }
      expect(grid.under_population?).to be_false
      expect(grid).to receive(:live_neighbors) { [:one, :two, :three, :four] }
      expect(grid.under_population?).to be_false
    end
  end

  describe "#overcrowding?" do
  end

  describe "#reproduction?" do
  end

end
