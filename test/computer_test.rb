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

  def test_it_can_make_a_two_unit_ship
    assert_equal 2, computer.ship.length
  end
  
end
