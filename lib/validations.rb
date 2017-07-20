module Validations

  def two_unit_sunk?
    return true if two_unit_ship == 2
  end

  def three_unit_sunk?
    return true if three_unit_ship == 3
  end

  def coord_valid?(coord)
    ship_1.include?(coord) ? false : true
  end

  def ship_1_coord_1_valid?(input)
    !board.include?(input) ? false : true
  end

  def ship_1_coord_1_validation_loop(input)
    unless player.ship_1_coord_1_valid?(input)
      invalid_placement
      ship_1_placement_coord_one
    end
  end

  def ship_1_coord_2_valid?(input)
    if ship_1[0]==input || !second_coord[ship_1[0]].include?(input) || !board.include?(input)
      return false
    else
      return true
    end
  end

  def ship_1_coord_2_validation_loop(input)
    unless player.ship_1_coord_2_valid?(input)
      invalid_placement
      ship_1_placement_coord_two
    end
  end

  def ship_2_coord_1_valid?(input)
    ship_1.include?(input) || !board.include?(input) ? false : true
  end

  def ship_2_coord_1_validation_loop(input)
    unless player.ship_2_coord_1_valid?(input)
      invalid_placement
      ship_2_placement_coord_one
    end
  end

  def ship_2_coord_2_valid?(input)
    if ship_1.include?(input) || !second_coord[ship_2[0]].include?(input) || !board.include?(input)
      return false
    else
      return true
    end
  end

  def ship_2_coord_2_validation_loop(input)
    unless player.ship_2_coord_2_valid?(input)
      invalid_placement
      ship_2_placement_coord_two
    end
  end

  def third_coord_valid?(input)
    if ship_1.include?(input) || third_coord[ship_2].nil? || !third_coord[ship_2].include?(input) || !board.include?(input)
      return false
    else
      return true
    end
  end

  def third_coord_validation_loop(input)
    unless player.third_coord_valid?(input)
      invalid_placement
      ship_2_placement_coord_three
    end
  end

end
