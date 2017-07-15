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
    assert computer.second_coord.include?("A4")
    assert computer.second_coord.include?("B2")
    assert computer.second_coord.include?("C3")
    assert computer.second_coord.include?("D1")
  end

  def test_can_tell_if_coord_is_off_board
    refute computer.second_coord.include?("D5")
    refute computer.second_coord.include?("A6")
    refute computer.second_coord.include?("A0")
  end

  def test_it_can_make_a_two_unit_ship
    computer.make_ship_one
    assert_equal 2, computer.ship_1.length
  end

  def test_third_coordinate_select_is_hash
    assert_instance_of Hash, computer.third_coord
  end

  def test_it_can_make_a_three_unit_ship
    computer.make_ship_one
    computer.make_ship_two
    assert_equal 3, computer.ship_2.length
  end
end
