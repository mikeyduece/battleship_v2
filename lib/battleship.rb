require './lib/computer'
require './lib/player'
require './lib/messages'
require './lib/colorize'

class Battleship
  include Messages
  attr_accessor :computer_board, :player_board
                :player, :computer

  def initialize
    @computer_board = [["A1","A2","A3","A4"],
                       ["B1","B2","B3","B4"],
                       ["C1","C2","C3","C4"],
                       ["D1","D2","D3","D4"]]
    @player_board   = [["A1","A2","A3","A4"],
                       ["B1","B2","B3","B4"],
                       ["C1","C2","C3","C4"],
                       ["D1","D2","D3","D4"]]
    @player         = Player.new
    @computer       = COmputer.new
  end

  def ship_1_placement_coord_one
    puts "Enter first coordinate for your 2 unit ship: ex. A1"
    input = gets.chomp.upcase
    print "> "
    player.ship_1_coord_1_validation(input)
  end

  def ship_1_placement_coord_two
    puts "Enter second coordinate for your 2 unit ship: ex. A1"
    input = gets.chomp.upcase
    print "> "
    if !board.include?(input) || !second_coord[input]
      ship_1_placement_coord_two
    else
      ship_1 << input
    end
  end

end
