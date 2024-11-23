def setup
  createCanvas(700, 700)
  @bubbles = 150.times.map { Bubble.new(rand(0..width), rand(0..height)) }
end

def draw
  background(0, 51, 102)

  @bubbles.each do |bubble|
    bubble.update
    bubble.display
  end
end

class Bubble
  def initialize(x, y)
    @x = x
    @y = y
    @size = rand(5..30)
    @speed = rand(1..3.5)
    @color = color(255, 255, 255, rand(100..200)) # 半透明
  end

  def update
    # 下から上へ
    @y -= @speed

    # 画面外に出たら再度位置を設定
    if @y < 0
      @y = height
      @x = rand(0..width)
    end
  end

  def display
    fill(@color)
    noStroke
    ellipse(@x, @y, @size)
  end
end