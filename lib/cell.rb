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
    # is it sunk
    # is it hit
    # is it fired_upon but miss
    # else "S" or "."

    # return "M" if @fired_upon == true && empty?
    # return "X" if @ship.sunk?
    #   if empty? == false
    # return "H" if @fired_upon == true
    # if show_ships == true
    #   if !empty? && !fired_upon?
    #     "S"
    #   else
    #     "."
    #   end
    # else
    #   "."
    #
    # end


    if show_ships == false
      if empty? == false && @ship.sunk?
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
      if empty? == false && !fired_upon?
        "S"
      elsif fired_upon?
        if empty? == true
          "M"
        elsif !@ship.sunk?
          "H"
        else
          "X"
        end
      else
        "."
      end
    end
  end
end
