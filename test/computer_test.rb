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
end
