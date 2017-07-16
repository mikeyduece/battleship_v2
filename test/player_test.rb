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

  def test_first_ship_coordinate_validation
    input = "A3"
    player.ship_1_coord_1_validation(input)
    assert_equal ["A3"], player.ship_1
  end

  def test_ship_1_coord_is_actually_in_array
    input = "A3"
    player.ship_1_coord_1_validation(input)
    assert_equal 1, player.ship_1.length
  end

  def test_it_can_recognize_invalid_coords
    input = "A5"
    refute player.ship_1_coord_1_validation(input)
  end

  def test_it_can_recognize_invalid_placement
    player.ship_1 = ["A3"]
    input  = "B4"
    refute player.ship_1_coord_2_validation(input)
  end

  def test_it_can_validate_ship_1_coord_1
    player.ship_1 = ["A1", "B1"]
    input = "C2"
    player.ship_2_coord_1_validation(input)
    assert_equal 1, player.ship_2.length
    assert_equal ["C2"], player.ship_2
  end

  def test_it_can_tell_if_ship_2_coord_1_is_invalid
    player.ship_1 = ["A1", "B1"]
    input = "A1"
    refute player.ship_2_coord_1_validation(input)
  end

  def test_it_can_recognize_invalid_placement_for_ship_2
    player.ship_2 = ["A1", "A2"]
    input         = "B2"
    require "pry"; binding.pry
    refute player.third_coord_validation(input)
  end


  def test_third_coord_validation
    player.ship_1 = ["D2", "D3"]
    player.ship_2 = ["A1", "A2"]
    input = "A3"
    player.third_coord_validation(input)
    assert_equal ["A1", "A2", "A3"], player.ship_2
  end

end
