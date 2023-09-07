$side = 80
$split = 9
def setup
  createCanvas($side * $split, $side * $split)
  angleMode(DEGREES)
  background(255)
end

def draw
  noLoop
  noStroke
  x = 0
  while x < width do
    y = 0
    while y < height do
      fill('#444444')
      arc(x, y, $side * 2, $side * 2, 0, 90)
      y += $side
    end
    x += $side
  end
end
