def setup
  createCanvas(800,800)
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
    ellipse(rand(0..900), rand(0..900), 30, 30)
  end
end
