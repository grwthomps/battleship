class Board

  attr_reader :cells

  def initialize
    @cells = {}
    ["A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4"].each do |cell|
      @cells[cell] = Cell.new(cell)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.count
      coord_nums = coordinates.map do |coordinate|
        coordinate[1].to_i
      end
      coord_nums.each_cons(2).all? { |x,y| y == x + 1 } && coord_nums[0] < coord_nums[1]
    else
      false
    end

  end

end
