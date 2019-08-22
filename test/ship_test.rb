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

  def test_it_gets_hit
    refute @cruiser.sunk?
    @cruiser.hit
    assert_equal 2, @cruiser.health

    @cruiser.hit
    assert_equal 1, @cruiser.health
    refute @cruiser.sunk?
  end

  def test_for_sunk
    refute @cruiser.sunk?
    10.times {@cruiser.hit}
    assert @cruiser.sunk?
  end
end
