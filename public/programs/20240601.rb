def setup
  createCanvas(700, 700)
  @circles = []
  @rate = 0.08
  frameRate(40)
  drawingContext.shadowColor = color(255)
  drawingContext.shadowBlur = 50
end

def draw
  background(0)
  noStroke
  if rand < @rate
    @circles << Circle.new(rand(0..width), rand(0..height))
  end

  @circles.each do |circle| 
    circle.update
    circle.display
    @circles.reject! { |c| c.finished? }
  end

end

class Circle
  attr_accessor :x, :y, :radius, :alpha, :c

  def initialize(x, y)
    @x = x
    @y = y
    @radius = 0
    @alpha = 255
    @c = rand(100..255)
  end

  def update
    self.radius = radius + 1
    self.alpha = alpha - 2
  end

  def display
    fill(0, 0, c, alpha)

    ellipse(x, y, radius * 2)
  end

  def finished?
    alpha <= 0
  end
end
