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

  def test_third_coord_validation
    player.ship_2 = ["A1", "A2"]
    input = "A3"
    actual = player.third_coord_validation(input)
    assert_equal ["A1", "A2", "A3"], actual
  end

end
