require 'colorize'
require 'terminal-table'
require './lib/computer'
require './lib/player'
require './lib/messages'

class Battleship
  include Messages
  attr_accessor :computer_board, :player_board,
                :player, :computer

  def initialize
    @computer_board = [["A"," "," "," "," "],
                       ["B"," "," "," "," "],
                       ["C"," "," "," "," "],
                       ["D"," "," "," "," "]]
    @player_board   = [["A"," "," "," "," "],
                       ["B"," "," "," "," "],
                       ["C"," "," "," "," "],
                       ["D"," "," "," "," "]]
    @player         = Player.new
    @computer       = Computer.new
  end

  def start
    place_computer_ships
    place_player_ships
    puts player_display
    puts computer_display
    fire_fight
  end

  def computer_display
    Terminal::Table.new :title => "Computer Board", :headings => [".", "1", "2", "3", "4"], :rows => computer_board, :style => {:width => 80, :padding_left => 3, :border_x => "=", :border_i => "x"}
  end

  def player_display
    Terminal::Table.new :title => "Player Board", :headings => [".", "1", "2", "3", "4"], :rows => player_board, :style => {:width => 80, :padding_left => 3, :border_x => "=", :border_i => "x"}
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
    if !player.ship_1_coord_1_validation(input)
      ship_1_placement_coord_one
    end
  end

  def ship_1_placement_coord_two
    puts "Enter second coordinate for your 2 unit ship: ex. A1"
    input = gets.chomp.upcase
    print "> "
    if !player.ship_1_coord_2_validation(input)
      ship_1_placement_coord_two
    end
  end

  def ship_2_placement_coord_one
    p "Enter first coordinate for 3 unit ship: ex A1"
    print "> "
    input = gets.chomp.upcase
    if !player.ship_2_coord_1_validation(input)
      ship_2_placement_coord_one
    end
  end

  def ship_2_placement_coord_two
    p "Enter second coordinate for 3 unit ship: ex A1"
    print "> "
    input = gets.chomp.upcase
    if !player.ship_2_coord_2_validation(input)
      ship_2_placement_coord_two
    end
  end

  def ship_2_placement_coord_three
    p "Enter last coordinate for 3 unit ship: ex A1"
    print "> "
    input = gets.chomp.upcase
    if !player.third_coord_validation(input)
      ship_2_placement_coord_three
    end
  end

  def player_shot_solution
    p "Enter coordinates to fire on the enemy fleet!"
    player.shot = gets.chomp.upcase
    print "> "
    player_shot_solution if !player.firing_solution(player.shot)
  end

  def fire_fight
    while (player.two_unit_ship != 2 && player.three_unit_ship != 3) || (computer.two_unit_ship != 2 && computer.three_unit_ship != 3)
      player_shot_solution
      player_turn
      computer.firing_solution
      computer_turn
    end
  end

  def computer_turn
    if player.ship_1.include?(computer.shot)
      render_player_board(computer.shot, "H")
      p "Your 2 unit ship was hit!"
      player.two_unit_ship += 1
    elsif player.ship_2.include?(computer.shot)
      render_player_board(computer.shot, "H")
      p "Your 3 unit ship was hit!"
      player.three_unit_ship += 1
    elsif player.two_unit_ship == 2
      render_player_board(computer.shot, "H")
      p "Your 2 unit ship has been sunk!"
    elsif player.three_unit_ship == 3
      render_player_board(computer.shot, "H")
      p "Your 3 unit ship has been sunk!"
    else
      render_player_board(computer.shot, "M")
      p "I have missed completely!"
    end
  end

  def player_turn
    if computer.ship_1.include?(player.shot)
      render_computer_board(player.shot, "H")
      p "You hit the Alliance's 2 unit ship!"
      computer.two_unit_ship += 1
    elsif computer.two_unit_ship == 2
      render_computer_board(player.shot, "H")
      p "You sunk the Alliance's 2 unit ship!"
    elsif computer.ship_2.include?(player.shot)
      render_computer_board(player.shot, "H")
      p "You hit the Alliance's 3 unit ship!"
      computer.three_unit_ship += 1
    elsif computer.three_unit_ship == 3
      render_computer_board(player.shot, "H")
      p "You sunk the Alliance's 3 unit ship!"
    else
      render_computer_board(player.shot, "M")
      p "You missed!"
    end
  end

  def render_player_board(shot, status)
    player_board.map do |row|
      row.map! do |coord|
        if coord == shot
          coord = status
        else
          coord = coord
        end
      end
    end
    puts player_display
  end

  def render_computer_board(shot, status)
    computer_board.map do |row|
      row.map! do |coord|
        if coord == shot
          coord = status
        else
          coord = coord
        end
      end
    end
    puts computer_display
  end

end
