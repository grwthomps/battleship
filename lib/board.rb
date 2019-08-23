class Board
  VALID_CELLS = ["A1", "A2", "A3", "A4",
        "B1", "B2", "B3", "B4",
        "C1", "C2", "C3", "C4",
        "D1", "D2", "D3", "D4"].freeze
  attr_reader :cells

  def initialize
    @cells = {}
    VALID_CELLS.each do |cell|
      @cells[cell] = Cell.new(cell)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def array_sequential?(array_1, array_2)
    letters_are_same = array_1.uniq.count == 1
    nums_are_same = array_2.uniq.count == 1
    letters = array_1.each_cons(2).all? { |x,y| y == x + 1 } && array_1[0] < array_1[1]
    nums = array_2.each_cons(2).all? { |x,y| y == x + 1 } && array_2[0] < array_2[1]
    return true if (letters == false && nums == true && letters_are_same == true) || (letters == true && nums == false && nums_are_same == true)
    else false
  end

  def valid_placement?(ship, coordinates)
    letters = []
    nums = []
    coordinates.each do |coordinate|
      nums << coordinate.gsub(/[A-Z]/, "").to_i
      letters << coordinate.gsub(/\d/, "").ord
    end
    checked_array = array_sequential?(letters, nums)
    return true if ship.length == coordinates.count && checked_array == true
    else false
  end

end
