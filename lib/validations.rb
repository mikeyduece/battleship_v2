module Validations

  def two_unit_sunk?
    return true if two_unit_ship == 2
  end

  def three_unit_sunk?
    return true if three_unit_ship == 3
  end

  def coord_valid?(coord)
    if ship_1.include?(coord)
      return false
    else
      return true
    end
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
    if ship_1.include?(input) || third_coord[ship_2].nil? || !third_coord[ship_2].include?(input) || !board.include?(input)
      return false
    else
      return true
    end
  end

end
