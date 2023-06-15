def setup
  createCanvas(800, 800)
  colorMode(RGB, 256)
  noStroke()
end

def draw
  noLoop()
  (1..1800).each do | i |
    if i.even?
      fill(random(127, 249), random(191, 252), 255)
    else 
      fill(random(191, 252), 255, random(127, 249))
    end
    ellipse(random(0, 900), random(0, 900), 30)
  end
end
