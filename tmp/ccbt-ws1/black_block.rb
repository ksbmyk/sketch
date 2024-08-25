$size = 50
def setup
  createCanvas(700, 700)
  background(0)
  rectMode(CENTER)
  noStroke
  frameRate(10)
  
end

def draw
  blendMode(BLEND)
  background(0)
  blendMode(SCREEN) 
  x = 0
  while x < width do
    y = 0
    while y < height do
      alpha = 255
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
