$side = 80
$split = 9
#ブルーナカラー
$colors = %w(#eb6100 #004c97 #15722c #fccc00)

def setup
  createCanvas($side * $split, $side * $split)
  background(0)
  blendMode(ADD)
end

def draw
  noLoop
  noStroke
  x = 0
  while x <= width do
    y = 0
    while y <= width do

      r = random(255)
      g = random(255)
      b = random(255)
      a = random(100, 200)
      fill(r, g, b, a)
      ellipse(x, y, $side * 2, $side * 2)
      y += $side
    end
    x += $side
  end
end
