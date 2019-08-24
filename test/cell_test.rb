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
    assert_equal true, @cell.empty?
  end

  def test_an_instance_of_ship
    assert_instance_of Ship, @cruiser
  end

  def test_placing_a_ship_on_it
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_it_hasnt_been_fired_upon
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.fired_upon?
  end

  def test_firing_on_it
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end

  def test_render_when_it_hasnt_been_fired_upon
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render
  end

  def test_render_when_shot_missed
    cell_1 = Cell.new("B4")
    cell_1.fire_upon
    assert_equal "M", cell_1.render
  end

  def test_render_when_it_has_a_ship
    cell_2 = Cell.new("C3")
    cell_2.place_ship(@cruiser)
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_render_when_shot_hit
    cell_2 = Cell.new("C3")
    cell_2.place_ship(@cruiser)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
    assert_equal false, @cruiser.sunk?
  end

  def test_render_when_ship_sunk
    cell_2 = Cell.new("C3")
    cell_2.place_ship(@cruiser)
    3.times {@cruiser.hit}
    assert_equal true, @cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
