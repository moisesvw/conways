class Grid
  attr_reader :table

  def initialize(table = nil)
    @table = table || Array.new(8).map { |row| row = Array.new(8) }
  end

  def neighbors(pos_x, pos_y)
    directions = {
      n:  [ pos_x - 1 , pos_y     ],
      nw: [ pos_x - 1 , pos_y - 1 ],
      ne: [ pos_x - 1 , pos_y + 1 ],
      w:  [ pos_x     , pos_y - 1 ],
      e:  [ pos_x     , pos_y + 1 ],
      s:  [ pos_x + 1 , pos_y     ],
      sw: [ pos_x + 1 , pos_y - 1 ],
      se: [ pos_x + 1 , pos_y + 1 ]
    }
    cells = []

    directions.each do |k, v|
      next if v.any? { |number| number < 0 }
      if table[v.first] && table[v.first][v.last]
        cells.push(table[v.first][v.last])
      end
    end

    cells
  end

  def live_neighbors(neighbors)
    neighbors.select { |neighbor| neighbor.live? }
  end

  def stable?(pos_x, pos_y)
    all_neighbors = neighbors(pos_x, pos_y)
    number_of_all_neighbors = live_neighbors(all_neighbors).count
    number_of_all_neighbors == 2 || number_of_all_neighbors == 3
  end

  def under_population?(pos_x, pos_y)
    all_neighbors = neighbors(pos_x, pos_y)
    number_of_all_neighbors = live_neighbors(all_neighbors).count
    number_of_all_neighbors < 2
  end

  def overcrowding?(pos_x, pos_y)
    all_neighbors = neighbors(pos_x, pos_y)
    number_of_all_neighbors = live_neighbors(all_neighbors).count
    number_of_all_neighbors > 3
  end

  def reproduction?(pos_x, pos_y, cell)
    all_neighbors = neighbors(pos_x, pos_y)
    number_of_all_neighbors = live_neighbors(all_neighbors).count
    number_of_all_neighbors == 3 && cell.died?
  end

  def generation
    table_cloned = table.clone

    table.each_with_index do |row, pos_x|
      row.each_with_index do |cell, pos_y|
        if under_population?(pos_x, pos_y) || overcrowding?(pos_x, pos_y)
          cell.die
        end

        if stable?(pos_x, pos_y) || reproduction?(pos_x, pos_y, cell)
          cell.live
        end
      end
    end

    table_cloned
  end
end
