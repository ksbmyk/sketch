# GENUARY 2024 jan1 Particles, lots of them.
# https://genuary.art/prompts

$x = 0.1
$y = 0.3
def setup
  createCanvas(800, 800)
  background(0)
end

def draw
  scale = 120
  a = 3
  b = 2
  c = 2
  d = 1
  
  translate(width/2, height/2)
  stroke(30, 150, 160, 80)

  (1..1000).each do | i |
    xx = Math.sin(a * $y) - Math.cos(a * $x) * c
    yy = Math.sin(b * $x) - Math.cos(b * $y) * d

    point(-xx * scale, yy * scale)
    $x = xx
    $y = yy
  end
  
  if(frameCount > 1000)
    noLoop()
  end
end
