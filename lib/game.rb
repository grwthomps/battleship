class Game

  attr_reader :computer_board,
              :user_board,
              :computer_cruiser,
              :computer_submarine,
              :user_coordinates,
              :user_cruiser,
              :user_submarine,
              :user_shot,
              :computer_shot

  def initialize
    @computer_board = Board.new
    @user_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @user_coordinates = nil
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @user_shot = nil
    @computer_shot = nil
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

  def placing_ships
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
  end

  def turn
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @user_board.render(true)

    # require 'pry'; binding.pry

    loop do
      puts "Enter the coordinate for your shot:"
      print "> "
      @user_shot = gets.chomp.upcase

      if @computer_board.valid_coordinate?(@user_shot) && @computer_board.cells[@user_shot].render == "."
        break
      elsif @computer_board.cells[@user_shot].render != "."
        puts "You already chose that coordinate previously."
      else
        puts "Invalid coordinate."
      end
    end

    @computer_board.cells[@user_shot].fire_upon
    user_result = @computer_board.cells[@user_shot].render

    if user_result == "M"
      puts "Your shot on #{@user_shot} was a miss."
    elsif user_result == "H"
      puts "Your shot on #{@user_shot} was a hit!"
    elsif user_result == "X"
      puts "Your shot on #{@user_shot} was a hit and you sunk their #{@computer_board.cells[@user_shot].ship.name}!"
    end

    loop do
      @computer_shot = @user_board.cells.keys.sample(1).first
      if @user_board.cells[@computer_shot].render == "."
        break
      end
    end

    @user_board.cells[@computer_shot].fire_upon
    computer_result = @user_board.cells[@computer_shot].render
    if computer_result == "M"
      puts "The computer's shot on #{@computer_shot} was a miss."
    elsif computer_result == "H"
      puts "The computer's shot on #{@computer_shot} was a hit!"
    elsif computer_result == "X"
      puts "The computer's shot on #{@computer_shot} was a hit and it sunk your #{@user_board.cells[@computer_shot].ship.name}!"
    end

  end

end
