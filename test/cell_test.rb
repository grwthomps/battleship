require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    # @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_its_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_there_isnt_a_ship_on_it
    assert_nil @cell.ship
  end

  def test_that_its_empty
    assert_equal true, @cell.empty?
  end

  def test_an_instance_of_ship
    assert_instance_of Ship, @cruiser
  end
  
  # def test_placing_a_ship_on_it
  #   @cell.place_ship(@cruiser)
  #   assert_equal @cruiser, @cell.ship
  #   assert_equal false, @cell.empty?
  # end
  #
  # def test_it_hasnt_been_fired_upon
  #   @cell.place_ship(@cruiser)
  #   assert_equal false, @cell.fired_upon?
  # end
  #
  # def test_firing_on_it
  #   @cell.place_ship(@cruiser)
  #   @cell.fire_upon
  #   assert_equal 2, @cell.ship.health
  #   assert_equal true, @cell.fired_upon?
  # end

end
