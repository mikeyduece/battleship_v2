require './test/test_helper'
require './lib/computer'

class ComputerTest < Minitest::Test
  attr_reader :computer

  def setup
    @computer = Computer.new
  end

  def test_it_exists
    assert_instance_of Computer, computer
  end

  def test_it_starts_with_a_board
    assert_instance_of Array, computer.board
  end

  def test_it_starts_with__ship
    assert_instance_of Array, computer.ship_1
  end

  def test_ship_1_is_empty_by_default
    assert_equal 0, computer.ship_1.length
  end

  def test_it_starts_with_a_second_ship
    assert_instance_of Array, computer.ship_2
  end

  def test_second_ship_start_empty
    assert_equal 0, computer.ship_2.length
  end

  def test_second_coord_select_is_a_hash
    assert_instance_of Hash, computer.second_coord
  end

  def test_second_coord_selection_contains_coords_on_board
    assert computer.second_coord.member?("A4")
    assert computer.second_coord.member?("B2")
    assert computer.second_coord.member?("C3")
    assert computer.second_coord.member?("D1")
  end

  def test_can_tell_if_coord_is_off_board
    refute computer.second_coord.member?("D5")
    refute computer.second_coord.member?("A6")
  end

  def test_it_can_make_a_two_unit_ship
    computer.make_ship_one
    assert_equal 2, computer.ship_1.length
  end

  def test_third_coordinate_select_is_hash
    assert_instance_of Hash, computer.third_coord
  end

  def test_ship_2_coord_1_valid?
    computer.ship_1 = ["D1", "D2"]
    assert computer.coord_valid?("A1")
  end

  def test_ship_2_coord_1_invalid?
    computer.ship_1 = ["D1", "D2"]
    refute computer.coord_valid?("D1")
  end

  def test_ship_2_coord_2_valid?
    computer.ship_1 = ["D1", "D2"]
    computer.ship_2 = ["A2"]
    assert computer.coord_valid?("A1")
  end

  def test_ship_2_coord_2_invalid?
    computer.ship_1 = ["D1", "D2"]
    refute computer.coord_valid?("D1")
  end

  def test_ship_2_coord_3_valid?
    computer.ship_1 = ["A4", "B4"]
    computer.ship_2 = ["B1","B2"]
    assert computer.coord_valid?("B3")
  end

  def test_ship_2_coord_3_invalid?
    computer.ship_1 = ["A4", "B4"]
    computer.ship_2 = ["B2","B3"]
    refute computer.coord_valid?("B4")
  end

  def test_it_can_make_a_three_unit_ship
    computer.make_ship_one
    computer.make_ship_two
    assert_equal 3, computer.ship_2.length
  end

  def test_it_can_place_both_ships
    computer.place_ships
    assert_equal 2, computer.ship_1.length
    assert_equal 3, computer.ship_2.length
  end

  def test_it_can_tell_if_third_coord_off_board
    refute computer.third_coord.member?("D5")
    refute computer.third_coord.member?("A6")
    refute computer.third_coord.member?("A0")
  end

  def test_it_can_shoot
    computer.firing_solution
    assert_equal 1, computer.shots.count
  end

  def test_it_can_shoot_more_than_once
    computer.firing_solution
    computer.firing_solution
    assert_equal 2, computer.shots.count
    computer.firing_solution
    assert_equal 3, computer.shots.count
  end

  def test_it_can_tell_if_ship_1_sunk
    computer.two_unit_ship = 2
    assert computer.two_unit_sunk?
  end

  def test_it_can_tell_if_ship_1_not_sunk
    computer.two_unit_ship = 1
    refute computer.two_unit_sunk?
  end

  def test_it_can_tell_if_ship_2_sunk
    computer.three_unit_ship = 3
    assert computer.three_unit_sunk?
  end

  def test_it_can_tell_if_ship_2_not_sunk
    computer.three_unit_ship = 2
    refute computer.three_unit_sunk?
  end

end
