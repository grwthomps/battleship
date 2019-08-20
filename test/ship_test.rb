require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require 'pry'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exits
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
  end

  def test_it_is_not_sunk
    assert_equal false, @cruiser.sunk?
  end

  def test_ship_first_hit
    @cruiser.hit
    assert_equal 2, @cruiser.health
  end

  def test_ship_second_hit
    @cruiser.hit
    assert_equal 1, @cruiser.health
    assert_equal false, @cruiser.sunk?
  end

  def test_ship_third_hit
    @cruiser.hit
    assert_equal 0, @cruiser.health
    assert_equal true, @cruiser.sunk?
  end
end
