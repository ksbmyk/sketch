# GENUARY 2024 jan9 "ASCII."
# https://genuary.art/prompts
# rbCanvasなら動く https://rbcanvas.net/p5/0.4.0/editor/rbcanvasp5_editor.html

attr_reader :bubbles

def setup
  createCanvas(600, 600)
  textSize(30)
  @bubbles = Array.new(30) { Bubble.new(rand(width), rand(-200.0..-100.0)) }
end

def draw
  background("blue")
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
    @speed = rand(3.0..8.0)
    @ascii_character = ";"
  end

  def fall
    self.y += speed
    if (y > height + 20) 
      self.y = rand(-200.0..-100.0)
    end
  end

  def display
    fill(255)
    text(ascii_character, x, y)
  end
end
