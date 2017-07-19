require './lib/board_selections'

class Computer
  include BoardSelections

  # attr_reader :board
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

  def make_ship_one
    coord_1 = board.sample
    ship_1 << coord_1
    coord_2 = second_coord[coord_1].sample
    ship_1 << coord_2
  end

  def make_ship_two
    coord_1 = ship_2_coord_1
    ship_2 << coord_1
    coord_2 = ship_2_coord_2
    ship_2 << coord_2
    coord_3 = ship_2_third_coord
    ship_2 << coord_3
    @ship_2 = ship_2.flatten
  end

  def ship_2_coord_1
    coord_1 = board.sample
    ship_2_coord_1 if ship_1.include?(coord_1)
    coord_1
  end

  def ship_2_coord_2
    coord_2 = second_coord[ship_2[0]].sample
    ship_2_coord_2 if ship_1.include?(coord_2)
    coord_2
  end

  def ship_2_third_coord
    count = 0
    make_ship_two if count == 5
    coord_3 = third_coord[ship_2]
    if ship_1.include?(coord_3)
      count += 1
      ship_2_third_coord
    end
    coord_3
  end

  def two_unit_sunk?
    return true if two_unit_ship == 2
  end

  def three_unit_sunk?
    return true if three_unit_ship == 3
  end

  def firing_solution
    @shot = board.sample
    if @shots.include?(@shot)
      firing_solution
    else
      @shots << @shot
    end
    @shot
  end
end
