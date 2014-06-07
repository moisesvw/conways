require_relative 'grid.rb'
require_relative 'cell.rb'

class Game
  attr_reader :grid

  def initialize
    states = [false, true]
    @table = Array.new(8).map do |row|
      8.times.map { |_| Cell.new(live: states.sample) }
    end
    @grid  = Grid.new(@table)
  end

  def tick
    sleep(0.5)
    grid.generation
  end
end