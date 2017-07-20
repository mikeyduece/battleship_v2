require 'colorize'
require 'terminal-table'
require './lib/computer'
require './lib/player'
require './lib/messages'
require './lib/validations'

class Battleship
  include Messages
  include Validations

  attr_accessor :computer_board, :player_board,
                :player, :computer, :shot_count

  def initialize
    @computer_board = [["A","A1","A2","A3","A4"], ["B","B1","B2","B3","B4"],
                       ["C","C1","C2","C3","C4"], ["D","D1","D2","D3","D4"]]
    @player_board   = [["A","A1","A2","A3","A4"], ["B","B1","B2","B3","B4"],
                       ["C","C1","C2","C3","C4"], ["D","D1","D2","D3","D4"]]
    @player         = Player.new
    @computer       = Computer.new
    @shot_count     = 0
  end

  def intro
    logo
    puts "               Welcome to BATTLESHIP!".white.bold
    puts "==========================================================="
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    print "> "
    input = gets.chomp
    case input
    when "p"||"P"             then start
    when "i"||"I"             then instructions; intro
    when quit_commands(input) then exit
    end
  end

  def start
    puts ascii_ship
    start_game
    puts computer_display
    puts player_display
    computer.place_ships
    @start = Time.now
    place_player_ships
    fire_fight
    total_time
    game_over
  end

  def computer_display
    Terminal::Table.new :title => "Computer Board", :headings => [".", "1", "2", "3", "4"], :rows => computer_board,
    :style => {:width => 45, :alignment => :center, :border_x => "=", :border_i => "x"}
  end

  def player_display
    Terminal::Table.new :title => "Player Board", :headings => [".", "1", "2", "3", "4"], :rows => player_board,
    :style => {:width => 45, :alignment => :center, :border_x => "=", :border_i => "x"}
  end

  def place_player_ships
    ship_1_placement_coord_one
    ship_1_placement_coord_two
    ship_2_placement_coord_one
    ship_2_placement_coord_two
    ship_2_placement_coord_three
  end

  def ship_1_placement_coord_one
    puts "Enter first coordinate for your 2 unit ship: ex. A1".cyan
    input = gets.chomp.upcase
    print "> "
    ship_1_coord_1_validation_loop(input)
    player.ship_1_coord_1(input)
  end

  def ship_1_placement_coord_two
    puts "Enter second coordinate for your 2 unit ship: ex. A1".cyan
    input = gets.chomp.upcase
    print "> "
    ship_1_coord_2_validation_loop(input)
    player.ship_1_coord_2(input)
  end

  def ship_2_placement_coord_one
    puts "Enter first coordinate for 3 unit ship: ex A1".cyan
    print "> "
    input = gets.chomp.upcase
    ship_2_coord_1_validation_loop(input)
    player.ship_2_coord_1(input)
  end

  def ship_2_placement_coord_two
    puts "Enter second coordinate for 3 unit ship: ex A1".cyan
    print "> "
    input = gets.chomp.upcase
    ship_2_coord_2_validation_loop(input)
    player.ship_2_coord_2(input)
  end

  def ship_2_placement_coord_three
    puts "Enter last coordinate for 3 unit ship: ex A1".cyan
    print "> "
    input = gets.chomp.upcase
    third_coord_validation_loop(input)
    player.ship_2_coord_3(input)
  end

  def player_shot
    puts "Enter coordinates to fire on the enemy fleet!".red.underline
    player.shot = gets.chomp.upcase
    print "> "
    player_shot if !player.firing_solution(player.shot)
  end

  def fire_fight
    until (player.two_unit_ship == 2 && player.three_unit_ship == 3) || (computer.two_unit_ship == 2 && computer.three_unit_ship == 3)
      player_shot
      player_turn
      computer.firing_solution
      computer_turn
    end
    @stop= Time.now
  end

  def computer_turn
    if player.ship_1.include?(computer.shot)
      render_player_board(computer.shot, "H")
      puts "Your 2 unit ship was hit!"
      player.two_unit_ship += 1
      puts "I sunk your two unit ship" if player.two_unit_sunk?
    elsif player.ship_2.include?(computer.shot)
      render_player_board(computer.shot,"H")
      puts "Your 3 unit ship was hit!"
      player.three_unit_ship += 1
      puts "I sunk your three unit ship" if player.three_unit_sunk?
    else
      render_player_board(computer.shot,"M")
      puts "I have missed completely!".white.bold
    end
  end

  def player_turn
    @shot_count += 1
    if computer.ship_1.include?(player.shot)
      render_computer_board(player.shot,"H")
      puts "You hit the Alliance's 2 unit ship!"
      computer.two_unit_ship += 1
      puts "You sunk the Alliance's 2 unit ship!" if computer.two_unit_sunk?
    elsif computer.ship_2.include?(player.shot)
      render_computer_board(player.shot,"H")
      puts "You hit the Alliance's 3 unit ship!"
      computer.three_unit_ship += 1
      puts "You sunk the Alliance's 3 unit ship!" if computer.three_unit_sunk?
    else
      render_computer_board(player.shot,"M")
      puts "You missed!".white.bold
    end
  end

  def render_player_board(shot, status)
    player_board.map {|row| shot_sub(row, shot, status)}
    puts player_display
  end

  def render_computer_board(shot, status)
    puts `clear`
    computer_board.map {|row| shot_sub(row, shot, status)}
    puts computer_display
  end

  def shot_sub(row, shot, status)
    row.map! do |coord|
      coord == shot ? coord = emoji[status] : coord = coord
    end
  end

end
