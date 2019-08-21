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

  def render(boolean = false)
    if boolean == false
      if empty? == false && @ship.health == 0
        "X"
      elsif fired_upon?
        if empty? == true
          "M"
        else
          "H"
        end
      elsif !fired_upon?
        "."
      end
    else
      if empty? == false
        "S"
      else
        "."
      end
    end
  end

end
