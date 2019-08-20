class Ship
  attr_reader :name, :length, :health, :hit

  def initialize(name, length)
    @name = name
    @length = length
    @health = 3
  end

  def it_gets_hit_and_sunk
    @cruiser.heath -= 1

  end

  def sunk?
    if @health > 0
      false
    else
      true
    end
  end

end
