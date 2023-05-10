$base = 80
$colors = ["#ba083d", "#444444", "#a9a7ad"]
def setup
  createCanvas($base*8, $base*8)
  noStroke
  noLoop
end

def draw
  background(255)
  d = width / 8
  x = d / 2
  while x < width do
    y = d / 2
    while y < width do
      c = rand(0..2)
      fill($colors[c])
      ellipse(x, y, d, d)
      y += d
    end
    x += d
  end
end
