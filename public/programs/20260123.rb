def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  noLoop
end

def draw
  background(0, 0, 100)
  noStroke
  
  50.times do
    draw_polygon(
      rand(width),
      rand(height),
      rand(50..150),
      rand(3..8)
    )
  end
end

def draw_polygon(cx, cy, radius, sides)
  hue = rand(180..280)
  saturation = rand(30..60)
  brightness = rand(70..95)
  alpha = rand(20..50)
  
  fill(hue, saturation, brightness, alpha)
  
  angle_offset = rand(TWO_PI)
  
  beginShape
  sides.times do |i|
    angle = angle_offset + TWO_PI * i / sides
    x = cx + cos(angle) * radius
    y = cy + sin(angle) * radius
    vertex(x, y)
  end
  endShape(CLOSE)
end
