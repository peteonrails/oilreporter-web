class Point
  attr_writer :x, :y

  def initialize(coords)
    coords.symbolize_keys!
    self.x = coords[:x]
    self.y = coords[:y]
  end

  def x
    @x.nil? ? 0 : @x.abs
  end

  def y
    @y.nil? ? 0 : @y.abs
  end

end
