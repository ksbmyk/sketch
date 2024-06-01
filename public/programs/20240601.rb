def setup
  createCanvas(700, 700)
  @circle = Circle.new(width/2, height/2)
end

def draw
  background(255)
  noStroke

  @circle.update
  @circle.display

  if @circle.finished?
    @circle.radius = 0
    @circle.alpha = 255
  end
end

class Circle
  attr_accessor :x, :y, :radius, :alpha

  def initialize(x, y)
    @x = x
    @y = y
    @radius = 0
    @alpha = 255
  end

  def update
    self.radius = radius + 1
    self.alpha = alpha - 1
  end

  def display
    fill(0, 0, 255, alpha)
    ellipse(x, y, radius * 2)
  end

  def finished?
    alpha <= 0
  end
end
