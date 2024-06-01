def setup
  createCanvas(700, 700)
  @circles = []
  @rate = 0.08
end

def draw
  background(255)
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
