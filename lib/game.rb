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
    sleep(0.1)
    grid.generation
  end

  def play_100
    300.times.each do |generation|
      tick.map do |row|
        row.map do |celula|
          print("∞ ") if celula.live?
        end
        print "\n"
      end
      print "\n"
      print "_"*40
    end
  end

end