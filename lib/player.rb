require './lib/board_selections'
require './lib/validations'

class Player
  include BoardSelections
  include Validations

  attr_accessor :ship_1, :ship_2, :shot, :shots, :two_unit_ship,
                :three_unit_ship

  def initialize
    @ship_1 = []
    @ship_2 = []
    @shots  = []
    @shot   = ""
    @two_unit_ship = 0
    @three_unit_ship = 0
  end

  def ship_1_coord_1(input)
    ship_1 << input if ship_1_coord_1_valid?(input)
  end

  def ship_1_coord_2(input)
    ship_1 << input if ship_1_coord_2_valid?(input)
  end

  def ship_2_coord_1(input)
    ship_2 << input if ship_2_coord_1_valid?(input)
  end

  def ship_2_coord_3(input)
    ship_2 << input if third_coord_valid?(input)
  end

  def ship_2_coord_2(input)
    ship_2 << input if ship_2_coord_2_valid?(input)
  end

  def firing_solution(input)
    if !board.include?(input) || @shots.include?(input)
      return false
    else
      @shots << input
    end
  end

end
