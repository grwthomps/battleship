class Game

  attr_reader :computer_board,
              :user_board,
              :computer_cruiser,
              :computer_submarine,
              :user_coordinates,
              :user_cruiser,
              :user_submarine

  def initialize
    @computer_board = Board.new
    @user_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @user_coordinates = nil
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
  end

  def computer_place_cruiser
    choices = []
    until @computer_board.valid_placement?(@computer_cruiser, choices)
      choices = @computer_board.cells.keys.sample(3)
    end
    @computer_board.place(@computer_cruiser, choices)
  end

  def computer_place_submarine
    choices = []
    until @computer_board.valid_placement?(@computer_submarine, choices)
      choices = @computer_board.cells.keys.sample(2)
    end
    @computer_board.place(@computer_submarine, choices)
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

      if @user_board.valid_placement?(@user_cruiser, @user_coordinates)   # can be broken. check with valid_placement instead.
        break
      else
        puts "Invalid coordinates. Please try again."
      end
    end
    @user_board.place(@user_cruiser, @user_coordinates)
    puts @user_board.render(true)
    loop do
      puts "Next, enter two coordinates for your Submarine. These must also be consecutive and cannot be diagonal."
      print "> "

      user_input = gets.chomp.upcase
      @user_coordinates = user_input.split(" ")

      if @user_board.valid_placement?(@user_submarine, @user_coordinates)   # can be broken. check with valid_placement instead.
        break
      else
        puts "Invalid coordinates. Please try again."
      end
    end
    @user_board.place(@user_submarine, @user_coordinates)
    puts @user_board.render(true)
    p "Keeps going..."
  end



end
