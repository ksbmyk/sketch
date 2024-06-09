# #minacoding 2024 June 9 "A Year Ago"
# https://minacoding.online/theme

$size = 50
def setup
  createCanvas(700, 700)
  background(0)
  rectMode(CENTER)
  noStroke
  noLoop
  blendMode(SCREEN)
end

def draw
  x = 0
  while x < width do
    y = 0
    while y < height do
      alpha = map(y, 0, height, 50, 255)
      fill(100, 150, 200, alpha)

      ellipse(x + $size / 2, y + $size / 2, rand(3..$size * 0.8))

      push
      translate(x + $size / 2, y + $size / 2)
      rotate(PI / 4)
      rect(0, 0, rand(3..$size * 0.7))
      pop

      rect(x + $size / 2, y + $size / 2, rand(3..$size * 0.5))

      r = rand(3..$size * 0.5)
      arc(x + $size / 2, y + $size / 2, r, r, PI/2*rand(0..3), PI/2*rand(0..3))

      y += $size 
    end
    x += $size
  end
end
