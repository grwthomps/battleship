class Game

  attr_reader :computer_board, :user_board, :cruiser, :submarine, :user_coordinates

  def initialize
    @computer_board = Board.new
    @user_board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @user_coordinates = nil
  end

  def computer_place_cruiser
    choices = []
    until @computer_board.valid_placement?(@cruiser, choices)
      choices = @computer_board.cells.keys.sample(3)
    end
    @computer_board.place(@cruiser, choices)
  end

  def computer_place_submarine
    choices = []
    until @computer_board.valid_placement?(@submarine, choices)
      choices = @computer_board.cells.keys.sample(2)
    end
    @computer_board.place(@submarine, choices)
  end

  def round
    computer_place_cruiser
    computer_place_submarine
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships: one Cruiser and one Submarine."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @user_board.render(true)
    loop do
      puts "First, enter three coordinates for your Cruiser. These must be consecutive. They cannot be diagonal."
      print "> "

      user_input = gets.chomp.upcase
      @user_coordinates = user_input.split(" ")

      if @user_coordinates.count != 3   # can be broken. check with valid_placement instead.
        puts "Invalid coordinates. Please try again."
      else
        break
      end
    end
    p "Keeps going..."
    p @user_coordinates
  end



end
