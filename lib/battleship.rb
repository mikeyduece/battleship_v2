require './lib/computer'
require './lib/player'
require './lib/messages'
require 'colorize'
require 'terminal-table'

class Battleship
  include Messages
  attr_accessor :computer_board, :player_board,
                :player, :computer

  def initialize
    @computer_board = [["A","A1","A2","A3","A4"],
                       ["B","B1","B2","B3","B4"],
                       ["C","C1","C2","C3","C4"],
                       ["D","D1","D2","D3","D4"]]
    @player_board   = [["A","A1","A2","A3","A4"],
                       ["B","B1","B2","B3","B4"],
                       ["C","C1","C2","C3","C4"],
                       ["D","D1","D2","D3","D4"]]
    @player         = Player.new
    @computer       = Computer.new
  end

  def computer_display
    computer_display = Terminal::Table.new :title => "Computer Board", :headings => [".", "1", "2", "3", "4"], :rows => computer_board, :style => {:width => 80, :padding_left => 3, :border_x => "=", :border_i => "x"}
  end

  def player_display
    player_display = Terminal::Table.new :title => "Player Board", :headings => [".", "1", "2", "3", "4"], :rows => player_board, :style => {:width => 80, :padding_left => 3, :border_x => "=", :border_i => "x"}
  end

  def place_computer_ships
    computer.make_ship_one
    computer.make_ship_two
  end

  def place_player_ships
    ship_1_placement_coord_one
    ship_1_placement_coord_two
    ship_2_placement_coord_one
    ship_2_placement_coord_two
    ship_2_placement_coord_three
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
    player.ship_2_coord_1_validation(input)
  end

  def ship_2_placement_coord_two
    p "Enter second coordinate for 3 unit ship: ex A1"
    print "> "
    input = gets.chomp.upcase
    player.ship_2_coord_2_validation
  end

  def ship_2_placement_coord_three
    p "Enter last coordinate for 3 unit ship: ex A1"
    print "> "
    input = gets.chomp.upcase
    player.third_coord_validation(input)
  end

  def fire_fight
    # while (player.two_unit_ship != 2 && player.three_unit_ship != 3) || (computer.two_unit_ship != 2 && computer.three_unit_ship != 3)

  end

  def computer_turn
    if player.ship_1.include?(computer.shot)
      p "Your 2 unit ship was hit!"
      player.two_unit_ship += 1
    elsif player.ship_2.include?(computer.shot)
      p "Your 3 unit ship was hit!"
      player.three_unit_ship += 1
    elsif player.two_unit_ship.count == 2
      p "Your 2 unit ship has been sunk!"
    elsif player.three_unit_ship.count == 3
      p "Your 3 unit ship has been sunk!"
    else
      p "The Browncoats have missed completely!"
    end
  end

  def player_turn
    if computer.ship_1.include?(player.shot)
      p "You hit the Alliance's 2 unit ship!"
      computer.two_unit_ship += 1
    elsif computer.two_unit_ship.count == 2
      p "You sunk the Alliance's 2 unit ship!"
    elsif computer.ship_2.include?(player.shot)
      p "You hit the Alliance's 3 unit ship!"
      computer.three_unit_ship += 1
    elsif computer.three_unit_ship.count = 3
      p "You sunk the Alliance's 3 unit ship!"
    else
      p "You missed!"
    end
  end

end
