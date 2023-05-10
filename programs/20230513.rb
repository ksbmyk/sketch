$base = 80
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
      fill(0)
      ellipse(x, y, d, d)
      y += d
    end
    x += d
  end
end
