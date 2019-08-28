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

  def computer_place_ship(ship)
    choices = []
    until @computer_board.valid_placement?(ship, choices)
      choices = @computer_board.cells.keys.sample(ship.length)
    end
    @computer_board.place(ship, choices)
  end

  def placing_ships
    computer_place_ship(@computer_cruiser)
    computer_place_ship(@computer_submarine)
    puts "====================================="
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your 2 ships: 1 Cruiser and 1 Submarine."
    puts "The Cruiser is 3 units long and the Submarine is 2 units long."
    puts @user_board.render(true)
    loop do
      puts "First, enter 3 coordinates for your Cruiser."
      puts "Note: These must be consecutive and cannot be diagonal. (Ex: a1 a2 a3)"
      print "> "

      user_input = gets.chomp.upcase
      @user_coordinates = user_input.split(" ")

      if @user_board.valid_placement?(@user_cruiser, @user_coordinates)
        break
      else
        puts "Invalid coordinates. Please try again."
      end
    end
    @user_board.place(@user_cruiser, @user_coordinates)
    puts @user_board.render(true)
    loop do
      puts "Next, enter 2 coordinates for your Submarine."
      puts "These must also be consecutive and cannot be diagonal. (Ex: b1 b2)"
      print "> "

      user_input = gets.chomp.upcase
      @user_coordinates = user_input.split(" ")


      if @user_board.valid_placement?(@user_submarine, @user_coordinates)
        break
      else
        puts "Invalid coordinates. Please try again."
      end
    end
    @user_board.place(@user_submarine, @user_coordinates)
  end

  def turn
    puts "============COMPUTER BOARD============"
    puts @computer_board.render
    puts "=============PLAYER BOARD============="
    puts @user_board.render(true)

    loop do
      puts "Enter the coordinate for your shot:"
      print "> "
      @user_shot = gets.chomp.upcase

      if @computer_board.valid_coordinate?(@user_shot) && @computer_board.cells[@user_shot].render == "."
        break
      elsif @user_shot == ""
        puts ""
        puts "No coordinate entered."
      elsif !@computer_board.valid_coordinate?(@user_shot)
        puts ""
        puts "Invalid coordinate."
      elsif @computer_board.cells[@user_shot].render != "."
        puts ""
        puts "You already chose that coordinate previously."
      end
    end

    @computer_board.cells[@user_shot].fire_upon
    user_result = @computer_board.cells[@user_shot].render
    puts ""
    puts "================RESULT================"

    if user_result == "M"
      puts ""
      puts "Your shot on #{@user_shot} was a miss."
    elsif user_result == "H"
      puts ""
      puts "Your shot on #{@user_shot} was a hit!"
    elsif user_result == "X"
      puts ""
      puts "Your shot on #{@user_shot} was a hit and you sunk my #{@computer_board.cells[@user_shot].ship.name}!"
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
      puts "My shot on #{@computer_shot} was a miss."
      puts ""
    elsif computer_result == "H"
      puts "My shot on #{@computer_shot} was a hit!"
      puts ""
    elsif computer_result == "X"
      puts "My shot on #{@computer_shot} was a hit and it sunk your #{@user_board.cells[@computer_shot].ship.name}!"
      puts ""
    end
  end

  def end_game
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "==============PLAYER BOARD=============="
    puts @user_board.render(true)
    puts "==============END OF GAME==============="
    puts ""

    if @user_board.render.count("X") == 5 && @computer_board.render.count("X") == 5
      puts "It's a tie!"
    elsif @computer_board.render.count("X") == 5
      puts "Congratulations! You won!!!"
    elsif @user_board.render.count("X") == 5
      puts "Sorry, you lost..."
    end
    puts "Want to play again?"
    puts ""
  end

end
