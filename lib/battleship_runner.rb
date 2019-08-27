require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

puts "Welcome to BATTLESHIP"

loop do
  puts "Enter p to play. Enter q to quit."
  print "> "

  user_input = gets.chomp.downcase

  if user_input == "p"
    game = Game.new
    game.placing_ships
    game.turn
    until game.user_board.render.count("X") == 5 || game.computer_board.render.count("X") == 5 do
      game.turn
    end
    game.end_game
  elsif user_input == "q"
    break
  else
    puts "Invalid input. Please try again."
  end
end
