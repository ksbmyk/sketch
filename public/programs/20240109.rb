attr_reader :bubbles

def setup
  createCanvas(400, 400)
  textSize(30)
  @bubbles = Array.new(10) { Bubble.new(rand(width), rand(-200.0..-100.0)) }
end

def draw
  background(255)
  @bubbles.each do |bubble|
    bubble.fall
    bubble.display
  end
end

class Bubble 
  attr_accessor :x, :y, :speed, :ascii_character

  def initialize(x, y)
    @x = x
    @y = y
    @speed = rand(1.0..5.0)
    @ascii_character = "*"
  end

  def fall
    self.y += speed
    if (y > height + 20) 
      self.y = rand(-200.0..-100.0)
    end
  end

  def display
    fill(0)
    text(ascii_character, x, y)
  end
end
