$base = 80
$split = 9
def setup
  createCanvas($base * $split, $base * $split)
  angleMode(DEGREES)
  background(255)
end

def draw
  noLoop
  noStroke
  x = 0
  while x < width do
    y = 0
    while y < width do
      fill('#444444')
      arc(x, y, $base * 2, $base * 2, 0, 90)
      y += $base
    end
    x += $base
  end
end