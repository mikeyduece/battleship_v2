require './test/test_helper'
require './lib/player'


class PlayerTest < Minitest::Test
  attr_reader :player

  def setup
    @player = Player.new
  end

  def test_it_exists
    assert_instance_of Player, player
  end

  def test_it_has_a_board
    assert_instance_of Array, player.board
  end

  def test_it_has_empty_ships_at_start
    assert_instance_of Array, player.ship_1
    assert_equal 0, player.ship_1.length
    assert_instance_of Array, player.ship_2
    assert_equal 0, player.ship_2.length
  end

  def test_first_ship_coordinate_valid
    input = "A3"
    player.ship_1_coord_1(input)
    assert_equal ["A3"], player.ship_1
  end

  def test_ship_1_validation
    input = "A3"
    assert player.ship_1_coord_1_valid?(input)
  end

  def test_ship_1_invalid
    refute player.ship_1_coord_1_valid?("A6")
  end

  def test_ship_1_coord_is_actually_in_array
    input = "A3"
    player.ship_1_coord_1(input)
    assert_equal 1, player.ship_1.length
  end

  def test_it_can_recognize_invalid_coords
    input = "A5"
    refute player.ship_1_coord_1_valid?(input)
  end

  def test_it_can_recognize_invalid_placement
    player.ship_1 = ["A3"]
    input  = "B4"
    refute player.ship_1_coord_2_valid?(input)
  end

  def test_it_can_place_two_unit_ship
    player.ship_1_coord_1("A1")
    player.ship_1_coord_2("A2")
    assert_equal 2, player.ship_1.length
  end

  def test_it_can_validate_ship_2_coord_1
    player.ship_1 = ["A1", "B1"]
    input = "C2"
    assert player.ship_2_coord_1_valid?(input)
  end

  def test_it_can_tell_if_ship_2_coord_1_is_invalid
    player.ship_1 = ["A1", "B1"]
    input = "A1"
    refute player.ship_2_coord_1_valid?(input)
  end

  def test_it_can_insert_ship_2_coord_1
    player.ship_2_coord_1("A1")
    assert_equal 1, player.ship_2.length
  end

  def test_it_can_validate_ship_2_coord_2
    player.ship_1 = ["A1", "B1"]
    player.ship_2 = ["C2"]
    input         = "C3"
    assert player.ship_2_coord_2_valid?(input)
  end

  def test_it_can_insert_ship_2_coord_2
    player.ship_1 = ["A1", "B1"]
    player.ship_2 = ["C2"]
    player.ship_2_coord_2("C3")
    assert_equal ["C2", "C3"], player.ship_2
    assert_equal 2, player.ship_2.length
  end

  def test_it_can_recognize_invalid_placement_for_ship_2
    player.ship_2 = ["A1", "A2"]
    input         = "B3"
    refute player.third_coord_valid?(input)
  end

  def test_third_coord_valid
    player.ship_1 = ["D2", "D3"]
    player.ship_2 = ["A1", "A2"]
    input         = "A3"
    player.third_coord_valid?(input)
  end

  def test_it_can_insert_ship_2_coord_3
    player.ship_1 = ["D2", "D3"]
    player.ship_2 = ["A1", "A2"]
    player.ship_2_coord_3("A3")
    assert_equal 3, player.ship_2.length
    assert_equal ["A1", "A2", "A3"], player.ship_2
  end

  def test_it_can_shoot
    input = "A1"
    player.firing_solution(input)
    assert_equal 1, player.shots.count
  end

  def test_it_can_shoot_more_than_once
    input = "A3"
    player.firing_solution(input)
    input = "C4"
    player.firing_solution(input)
    assert_equal 2, player.shots.count
    input = "C1"
    player.firing_solution(input)
    assert_equal 3, player.shots.count
  end

  def test_it_can_validate_shots
    input = "Z3"
    refute player.firing_solution(input)
  end

  def test_it_can_tell_if_shot_has_been_chosen_already
    player.firing_solution("A3")
    player.firing_solution("A1")
    refute player.firing_solution("A1")
  end

end
