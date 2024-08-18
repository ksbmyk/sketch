# #minacoding 2024 June 9 "A Year Ago"
# https://minacoding.online/theme

$size = 50
def setup
  createCanvas(700, 700)
  background(255)
  rectMode(CENTER)
  noStroke
  frameRate(10)
  
end

def draw
  background(255)
  x = 0
  while x < width do
    y = 0
    while y < height do
      alpha = 100
      fill(100, 150, 200, alpha)

      ellipse(x + $size / 2, y + $size / 2, rand(3..$size * 0.8))

      push
      translate(x + $size / 2, y + $size / 2)
      rotate(PI / 4)
      rect(0, 0, rand(3..$size * 0.7))
      pop

      rect(x + $size / 2, y + $size / 2, rand(3..$size * 0.5))
      y += $size 
    end
    x += $size
  end
end
