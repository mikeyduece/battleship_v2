module FireFight

  def fire_fight
    until (player.two_unit_sunk? && player.three_unit_sunk?) ||
      (computer.two_unit_sunk? && computer.three_unit_sunk?)
      player_shot
      player_turn
      computer.firing_solution
      computer_turn
    end
    @stop= Time.now
  end

  def register_computer_hit_player_ship_1(shot)
    render_player_board(shot, "H")
    puts "Your 2 unit ship was hit!".magenta
    player.two_unit_ship += 1
    puts "I sunk your two unit ship".red.bold if player.two_unit_sunk?
  end

  def register_computer_hit_player_ship_2(shot)
    render_player_board(shot,"H")
    puts "Your 3 unit ship was hit!".magenta
    player.three_unit_ship += 1
    puts "I sunk your three unit ship".red.bold if player.three_unit_sunk?
  end

  def register_computer_miss(shot)
    render_player_board(shot,"M")
    puts "I have missed completely!".white.bold
  end

  def register_player_hit_computer_ship_1(shot)
    render_computer_board(shot,"H")
    puts "You hit the Alliance's 2 unit ship!".blue
    computer.two_unit_ship += 1
    puts "You sunk the Alliance's 2 unit ship!".white.bold if computer.two_unit_sunk?
  end

  def register_player_hit_computer_ship_2(shot)
    render_computer_board(shot,"H")
    puts "You hit the Alliance's 3 unit ship!".blue
    computer.three_unit_ship += 1
    puts "You sunk the Alliance's 3 unit ship!" if computer.three_unit_sunk?
  end

  def register_player_miss_computer(shot)
    render_computer_board(shot,"M")
    puts "You missed!".white.bold
  end

  def shot_sub(row, shot, status)
    row.map! {|coord| coord == shot ? coord = emoji[status] : coord = coord}
  end
end
