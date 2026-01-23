def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  noLoop
end

def draw
  background(0, 0, 100)
  
  40.times do
    draw_filled_polygon(
      rand(width),
      rand(height),
      rand(50..150),
      rand(3..8)
    )
  end

  10.times do
    draw_outline_polygon(
      rand(width),
      rand(height),
      rand(50..150),
      rand(3..8)
    )
  end
end

def draw_filled_polygon(cx, cy, radius, sides)
  hue = rand(180..280)
  saturation = rand(30..60)
  brightness = rand(70..95)
  alpha = rand(20..50)
  
  noStroke
  fill(hue, saturation, brightness, alpha)
  
  draw_polygon_shape(cx, cy, radius, sides)
end

def draw_outline_polygon(cx, cy, radius, sides)
  hue = rand(180..280)
  saturation = rand(40..70)
  brightness = rand(50..80)
  alpha = rand(30..60)

  noFill
  stroke(hue, saturation, brightness, alpha)
  strokeWeight(rand(1.0..3.0))
  
  draw_polygon_shape(cx, cy, radius, sides)
end

def draw_polygon_shape(cx, cy, radius, sides)
  angle_offset = rand(TWO_PI)

  beginShape
  sides.times do |i|
    angle = angle_offset + TWO_PI * i / sides
    x = cx + Math.cos(angle) * radius
    y = cy + Math.sin(angle) * radius
    vertex(x, y)
  end
  endShape(CLOSE)
end
