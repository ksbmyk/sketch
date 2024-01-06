# GENUARY 2024 jan1 "Particles, lots of them."
# https://genuary.art/prompts

def setup
  @x = 0.1
  @y = 0.3
  createCanvas(700, 700)
  background(0)
end

def draw
  scale = 120
  a = 4
  b = 2

  translate(width/2, height/2)
  stroke(255, 255, 255, 50)

  1000.times do
    c = Math.sin(a * @y) - Math.tan(a * @x)
    d = Math.sin(b * @x) - Math.cos(b * @y)
    
    point(c * scale, d * scale)
    @x = c
    @y = d
  end
  
  if(frameCount > 1000)
    noLoop()
    
    blendMode(HARD_LIGHT)
    fill(255)
    noStroke()
    translate(-width / 2, -height / 2)

    ctx = drawingContext
    rg = ctx.createRadialGradient(width / 2, height / 2, 100, width / 2, height / 2, 300)
    rg.addColorStop(0, '#e2a872')
    rg.addColorStop(1, '#527e99')
    ctx.fillStyle = rg
    circle(width / 2, height / 2, width * 2)
  end
end
