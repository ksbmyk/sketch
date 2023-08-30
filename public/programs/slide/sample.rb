def setup
  createCanvas(800, 800)
  colorMode(RGB)
  background(0, 30, 70)
  blendMode(OVERLAY)
end

def draw
  noLoop
  1500.times do | i |
    if i.even?
      noStroke
      fill(170, 200, 255)
    else
      stroke(170, 200, 255)
      fill(255, 255, 255, 100)
    end
    ellipse(random(0, 900), random(0, 900), 30)
  end
end
