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
  a = 4
  b = 2

  translate(width/2, height/2)
  stroke(255, 255, 255, 80)

  (1..1000).each do | i |
    xx = Math.sin(a * $y) - Math.tan(a * $x)
    yy = Math.sin(b * $x) - Math.cos(b * $y)
    
    point(xx * scale, yy * scale)
    $x = xx
    $y = yy
  end
  
  if(frameCount > 1000)
    noLoop()
    
    blendMode(HARD_LIGHT)
    fill(255)
    noStroke()
    translate(-width/2, -height/2)

    ctx = drawingContext
    rg = ctx.createRadialGradient(width/2, height/2, 100, width/2, height/2, 300)
    rg.addColorStop(0, '#e2a872')
    rg.addColorStop(1, '#527e99')
    ctx.fillStyle = rg
    circle(width/2, height/2, width*2)
  end
end
