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
    if ship_1[0]==input || !second_coord[ship_1[0]].include?(input) ||
      !board.include?(input)
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
    if ship_1.include?(input) || !second_coord[ship_2[0]].include?(input) ||
      !board.include?(input)
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
    if ship_1.include?(input) || third_coord[ship_2].nil? ||
      !third_coord[ship_2].include?(input) || !board.include?(input)
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

  def player_turn
    @shot_count += 1
    if computer.ship_1.include?(player.shot)
      register_player_hit_computer_ship_1(player.shot)
    elsif computer.ship_2.include?(player.shot)
      register_player_hit_computer_ship_2(player.shot)
    else
      register_player_miss_computer(player.shot)
    end
  end

  def computer_turn
    if player.ship_1.include?(computer.shot)
      register_computer_hit_player_ship_1(computer.shot)
    elsif player.ship_2.include?(computer.shot)
      register_computer_hit_player_ship_2(computer.shot)
    else
      register_computer_miss(computer.shot)
    end
  end

  # def shot_sub(row, shot, status)
  #   row.map! {|coord| coord == shot ? coord = emoji[status] : coord = coord}
  # end


end
