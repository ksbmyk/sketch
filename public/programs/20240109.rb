# GENUARY 2024 jan9 "ASCII."
# https://genuary.art/prompts

def setup
  createCanvas(600, 600)
  colorMode(HSB, 360, 100, 100, 100)
  textSize(30)
  # xは画面横のランダムな位置、 yは画面外側(上)のランダムな位置にしてばらばら落ちる風に
  @drops = Array.new(30) { Drop.new(rand(0..width), rand(-200.0..-100.0)) }
end

def draw
  h = 206
  s = 28
  b = 92
  a = 100
  s = s < 100 ? s + frameCount / 10 : 100
  b = b > 0 ? b - frameCount / 10 : 0
  background(h, s, b, a)
  @drops.each do |drop|
    drop.fall
    drop.display(frameCount)
  end
end

class Drop 
  attr_accessor :x, :y, :speed, :ascii_character

  def initialize(x, y)
    @x = x
    @y = y
    @speed = rand(3.0..8.0)
    @ascii_character = [";", "*"]
  end

  def fall
    self.y += speed
    if (y > height + 20) 
      self.y = rand(-200.0..-100.0) # 画面の外までいったら初期化
    end
  end

  def display(frame_count)
    fill(255)
    c = frame_count < 600 ? ascii_character[0] : ascii_character[1]
    text(c, x, y)
  end
end
