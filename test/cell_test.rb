require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)


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
    assert @cell.empty?
  end

  def test_placing_a_ship_on_it
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    refute @cell.empty?
  end

  def test_it_hasnt_been_fired_upon
    @cell.place_ship(@cruiser)
    refute @cell.fired_upon?
  end

  def test_firing_on_it
    @cell.place_ship(@cruiser)
    assert_equal 3, @cell.ship.health
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    assert @cell.fired_upon?
  end

  def test_render_when_it_hasnt_been_fired_upon
    assert_equal ".", @cell.render(true)
    assert_equal ".", @cell.render
  end

  def test_render_when_shot_missed
    @cell.fire_upon
    assert_equal "M", @cell.render(true)
    assert_equal "M", @cell.render
  end

  def test_render_when_it_has_a_ship
    @cell.place_ship(@cruiser)
    assert_equal ".", @cell.render
    assert_equal "S", @cell.render(true)
  end

  def test_render_when_shot_hit
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal "H", @cell.render(true)
    assert_equal "H", @cell.render
    refute @cruiser.sunk?
  end

  def test_render_when_ship_sunk
    dinghy = Ship.new("Cruiser", 1)
    @cell.place_ship(dinghy)
    @cell.fire_upon
    assert dinghy.sunk?
    assert_equal "X", @cell.render(true)
    assert_equal "X", @cell.render
  end
end
