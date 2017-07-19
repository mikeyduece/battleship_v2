require './lib/board_selections'

class Player
  include BoardSelections

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

  def ship_1_coord_1_valid?(input)
    if !board.include?(input)
      return false
    else
      return true
    end
  end

  def ship_1_coord_2_valid?(input)
    if ship_1[0]==input || !second_coord[ship_1[0]].include?(input) || !board.include?(input)
      return false
    else
      return true
    end
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

  def ship_2_coord_1_valid?(input)
    if ship_1.include?(input) || !board.include?(input)
      return false
    else
      true
    end
  end

  def ship_2_coord_2_valid?(input)
    if ship_1.include?(input) || !second_coord[ship_2[0]].include?(input) || !board.include?(input)
      return false
    else
      return true
    end
  end

  def third_coord_valid?(input)
    if ship_1.include?(input) || !third_coord[ship_2].include?(input) || !board.include?(input)
      return false
    else
      return true
    end
  end

  def two_unit_sunk?
    return true if two_unit_ship == 2
  end

  def three_unit_sunk?
    return true if three_unit_ship == 3
  end

  def firing_solution(input)
    if !board.include?(input) || @shots.include?(input)
      return false
    else
      @shots << input
    end
  end

end
