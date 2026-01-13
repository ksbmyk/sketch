def setup
  createCanvas(700, 700)
  noLoop
  colorMode(HSB, 360, 100, 100, 100)
end

def draw
  background(220, 80, 15)
  
  # Hexagonal tile size
  hex_radius = 80
  
  # Grid spacing for hexagonal tiling
  col_width = hex_radius * Math.sqrt(3)
  row_height = hex_radius * 1.5
  
  # Draw hexagonal grid
  row = -1
  while row * row_height < height + row_height * 2
    col = -1
    y_offset = (row % 2 == 0) ? 0 : col_width / 2.0
    
    while col * col_width < width + col_width * 2
      cx = col * col_width + y_offset
      cy = row * row_height
      draw_p6m_cell(cx, cy, hex_radius)
      col += 1
    end
    row += 1
  end
end

def draw_p6m_cell(cx, cy, radius)
  push
  translate(cx, cy)
  
  # p6m
  6.times do |i|
    angle = i * PI / 6
    stroke(200, 30, 40, 50)
    strokeWeight(1)
    x1 = cos(angle) * radius
    y1 = sin(angle) * radius
    x2 = cos(angle + PI) * radius
    y2 = sin(angle + PI) * radius
    line(x1, y1, x2, y2)
  end
  
  num_rings = 5
  num_rings.times do |i|
    t = i.to_f / (num_rings - 1)
    r = radius * (0.2 + t * 0.7)
    
    hue = 180 + t * 40
    saturation = 60 + t * 30
    brightness = 55 + (1 - t) * 30
    
    stroke(hue, saturation, brightness)
    strokeWeight(2)
    noFill
    
    if i % 2 == 0
      draw_hexagon(0, 0, r)
    else
      ellipse(0, 0, r * 2, r * 2)
    end
  end
  
  fill(190, 70, 80)
  noStroke
  ellipse(0, 0, 6, 6)
  
  6.times do |i|
    angle = i * PI / 3
    x = cos(angle) * radius
    y = sin(angle) * radius
    fill(210, 60, 60)
    ellipse(x, y, 4, 4)
  end
  
  pop
end

def draw_hexagon(cx, cy, radius)
  beginShape
  6.times do |i|
    angle = i * PI / 3
    x = cx + cos(angle) * radius
    y = cy + sin(angle) * radius
    vertex(x, y)
  end
  endShape(CLOSE)
end
