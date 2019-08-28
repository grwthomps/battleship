VALID_CELLS = ["A1", "A2", "A3", "A4",
  "B1", "B2", "B3", "B4",
  "C1", "C2", "C3", "C4",
  "D1", "D2", "D3", "D4"].freeze

class Board
  attr_reader :cells, :letters, :rendered_board

  def initialize
    @cells = create_cells
  end

  def create_cells
    cells = {}
    VALID_CELLS.each do |cell|
      cells[cell] = Cell.new(cell)
    end
    cells
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def break_up_coords(coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate|
      numbers << coordinate.gsub(/[A-Z]/, "").to_i
      letters << coordinate.gsub(/\d/, "").ord
    end
    [letters, numbers]
  end

  def array_sequential?(coordinates)
    letters, numbers = break_up_coords(coordinates)

    letters_are_same = letters.uniq.count == 1
    nums_are_same = numbers.uniq.count == 1

    letters_consec = letters.each_cons(2).all? { |x,y| y == x + 1 } && letters[0] < letters[1]
    nums_consec = numbers.each_cons(2).all? { |x,y| y == x + 1 } && numbers[0] < numbers[1]

    return (nums_consec && letters_are_same) || (letters_consec && nums_are_same)
  end

  def all_empty?(coordinates)
    coordinates.all? { |coordinate| @cells[coordinate].empty? }
  end

  def valid_placement?(ship, coordinates)
    coord_check = coordinates.map do |coordinate|
      valid_coordinate?(coordinate)
    end

    return false if coord_check.include?(false)
    return false unless all_empty?(coordinates)
    return false if ship.length != coordinates.count
    array_sequential?(coordinates)
  end

  def place(ship, coordinates)
    return false unless valid_placement?(ship, coordinates)
    coordinates.each { |coordinate| @cells[coordinate].place_ship(ship) }
  end

  def render(boolean = false)
    line_1 = "  1 2 3 4 \n"
    line_2 = "A #{@cells["A1"].render(boolean)} #{@cells["A2"].render(boolean)} #{@cells["A3"].render(boolean)} #{@cells["A4"].render(boolean)} \n"
    line_3 = "B #{@cells["B1"].render(boolean)} #{@cells["B2"].render(boolean)} #{@cells["B3"].render(boolean)} #{@cells["B4"].render(boolean)} \n"
    line_4 = "C #{@cells["C1"].render(boolean)} #{@cells["C2"].render(boolean)} #{@cells["C3"].render(boolean)} #{@cells["C4"].render(boolean)} \n"
    line_5 = "D #{@cells["D1"].render(boolean)} #{@cells["D2"].render(boolean)} #{@cells["D3"].render(boolean)} #{@cells["D4"].render(boolean)} \n"
    "\n" + line_1 + line_2 + line_3 + line_4 + line_5 + "\n"

  end

end
