$side = 80
$split = 9
$colors = ["#ba083d", "#444444", "#a9a7ad"]
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
      fill($colors[rand(0..2)])
      arc(x, y, $side * 2, $side * 2, 0, 90)
      y += $side
    end
    x += $side
  end
end
