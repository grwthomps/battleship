class Board

  attr_reader :actual_board, :cells

  def initialize
    @cells = {}
    create_board
  end

  def create_board
    cell_array = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

    cell_array.map do |cell|
      @cells[cell] = Cell.new(cell)
    end
  end

end
