class Cell

  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if empty? == false
      @ship.hit
    end
    @fired_upon = true
  end

  def render(show_ships = false)
    return "M" if fired_upon? && empty?
    return "X" if !empty? && @ship.sunk?
    return "H" if fired_upon? && !empty?
    return "S" if show_ships == true && !empty?
    return "." if !fired_upon?
  end
end
