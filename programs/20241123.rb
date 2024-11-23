def setup
  createCanvas(600, 600)
  $glass = createGraphics(200, 300)
  @bubbles = 100.times.map { Bubble.new(rand(0..200), rand(0..300)) }
end

def draw
  background(0, 128, 128)

  $glass.clear
  @bubbles.each do |bubble|
    bubble.update
    bubble.display
  end

  # アイス
  noStroke
  fill(248, 244, 227)
  arc(300, 300, 200, 200, PI, TWO_PI);

  # グラス
  image($glass, 200, 300)
  # チェリー
  fill(200, 0, 0)
  ellipse(380, 280, 50)

  # グラス
  fill(255, 255, 255, 50)
  stroke(255)
  strokeWeight(3)
  rect(200, 300, 200, 300)
end

class Bubble
  def initialize(x, y)
    @x = x
    @y = y
    @size = rand(5..15)
    @speed = rand(1..3)
    @color = color(255, 255, 255, rand(100..200)) # 半透明
  end

  def update
    # 下から上へ
    @y -= @speed

    # グラスの範囲を超えないようにする
    if @y - @size / 2 < 0
      @y = 300 - @size / 2 # 上端を超えないように再設定
    end

    if @y + @size / 2 > 300
      @y = @size / 2 # 下端を超えないように再設定
    end
  end

  def display
    $glass.fill(@color)
    $glass.noStroke
    $glass.ellipse(@x, @y, @size)
  end
end
