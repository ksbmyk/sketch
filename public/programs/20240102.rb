# GENUARY 2024 jan2 "No palettes."
# https://genuary.art/prompts

$side = 80
$split = 9
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
    while y <= height do
      r = random(50)
      g = random(255)
      b = random(255)
      a = random(100, 200)
      fill(r, g, b, a)
      diamond_shape($side/2, $side, x, y)
      y += $side
    end
    x += $side / 2
  end
end

def diamond_shape(w, h, x, y)
  push()
  translate(x, y)

  beginShape()
  vertex(0, -h)
  vertex(w, 0)
  vertex(0, h)
  vertex(-w, 0)
  endShape()
  
  pop()
end
