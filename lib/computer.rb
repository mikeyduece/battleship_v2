require './lib/board_selections'
require './lib/validations'


class Computer

  include BoardSelections
  include Validations

  attr_accessor :ship_1, :ship_2, :shot, :shots,
                :two_unit_ship, :three_unit_ship

  def initialize
    @ship_1 = []
    @ship_2 = []
    @shots  = []
    @shot   = nil
    @two_unit_ship = 0
    @three_unit_ship = 0
  end

  def place_ships
    ship_1.clear
    ship_2.clear
    make_ship_one
    make_ship_two
  end

  def make_ship_one
    coord_1 = board.sample
    ship_1 << coord_1
    coord_2 = second_coord[coord_1].sample
    ship_1 << coord_2
  end

  def make_ship_two
    ship_2.clear
    ship_2_coord_1
    ship_2_coord_2
    ship_2_coord_3
  end

  def ship_2_coord_1
    coord_1 = board.sample
    coord_valid?(coord_1) ? ship_2 << coord_1 : make_ship_two
  end

  def ship_2_coord_2
    coord_2 = second_coord[ship_2[0]].sample
    coord_valid?(coord_2) ? ship_2 << coord_2 : make_ship_two
  end

  def ship_2_coord_3
    coord_3 = second_coord[ship_2[0]].sample
    if coord_valid?(coord_3) && !ship_2.nil? && ship_2.length == 2
      ship_2 << coord_3
    else
      make_ship_two
    end
  end

  def firing_solution
    @shot = board.sample
    @shots.include?(@shot) ? firing_solution : @shots << @shot
    @shot
  end

end
