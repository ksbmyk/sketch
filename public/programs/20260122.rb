# GENUARY 2026 jan22 "Pen plotter ready."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  noLoop
end

def draw
  background(255)
  translate(width / 2, height / 2)
  
  stroke(0)
  strokeWeight(1)
  noFill
  
  n = 5
  d = 71

  radii = [50, 100, 150, 200, 250, 300]
  
  radii.each do |radius|
    draw_maurer_rose(radius, n, d)
  end
end

def draw_maurer_rose(radius, n, d)
  beginShape
  360.times do |k|
    theta = radians(k * d)
    r = radius * sin(n * theta)
    x = r * cos(theta)
    y = r * sin(theta)
    vertex(x, y)
  end
  endShape(CLOSE)
end
