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
    @computer       = Computer.new
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
    player.ship_1_coord_2_validation(input)
  end

  def ship_2_placement_coord_one
    p "Enter first coordinate for 3 unit ship: ex A1"
    print "> "
    input = gets.chomp.upcase
    if !board.include?(input)
      ship_2_placement_coord_one
    else
      ship_2 << input
    end
  end

  def ship_2_placement_coord_two
    p "Enter second coordinate for 3 unit ship"
    print "> "
    input = gets.chomp.upcase
    if !board.include?(input) || !second_coord[input] || ship_1.include?(input)
      ship_2_placement_coord_two
    else
      ship_2 << input
    end
  end

  def ship_2_placement_coord_three
    p "Enter last coordinate for 3 unit ship"
    print "> "
    input = gets.chomp.upcase
    player.third_coord_validation(input)
  end

end
