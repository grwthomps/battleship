require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

puts "Welcome to BATTLESHIP"
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
elsif user_input == "q"
  # close program
else
  puts "Invalid input. Closing program."
end