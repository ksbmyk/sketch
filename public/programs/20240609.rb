# #minacoding 2024 June 6 "Morning"
# https://minacoding.online/theme

$size = 50
def setup
  createCanvas(700, 700)
  rectMode(CENTER)
  noStroke
  noLoop
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
      y += $size 
    end
    x += $size
  end
end
