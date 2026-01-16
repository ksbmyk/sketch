def setup
  createCanvas(700, 700)
  noLoop
  colorMode(HSB, 360, 100, 100, 100)
end

def draw
  background(220, 80, 15)
  
  hex_radius = 80
  
  col_width = hex_radius * 1.2
  row_height = hex_radius * 1.0
  
  row = -1
  while row * row_height < height + row_height * 2
    col = -1
    y_offset = (row % 2 == 0) ? 0 : col_width / 2.0
    
    while col * col_width < width + col_width * 2
      cx = col * col_width + y_offset
      cy = row * row_height
      draw_mirror_cell(cx, cy, hex_radius)
      col += 1
    end
    row += 1
  end
end

def draw_mirror_cell(cx, cy, radius)
  push
  translate(cx, cy)
  

  # p6m
  num_layers = 8

  num_layers.times do |layer|
    t = layer.to_f / (num_layers - 1)
    r_start = radius * (0.1 + t * 0.85)
    r_end = radius * (0.15 + t * 0.85)
    
    hue = 180 + t * 40
    saturation = 50 + t * 40
    brightness = 50 + (1 - t) * 40
    
    stroke(hue, saturation, brightness, 60)
    strokeWeight(1.2)

    12.times do |i|
      angle = i * PI / 6

      if i.even?
        x1 = cos(angle) * r_start * 0.3
        y1 = sin(angle) * r_start * 0.3
        x2 = cos(angle) * r_end
        y2 = sin(angle) * r_end
      else
        x1 = cos(angle) * r_start * 0.5
        y1 = sin(angle) * r_start * 0.5
        x2 = cos(angle) * r_end * 0.9
        y2 = sin(angle) * r_end * 0.9

        if layer.even?
          branch_angle1 = angle - PI / 12
          branch_angle2 = angle + PI / 12
          bx1 = cos(branch_angle1) * r_end * 0.7
          by1 = sin(branch_angle1) * r_end * 0.7
          bx2 = cos(branch_angle2) * r_end * 0.7
          by2 = sin(branch_angle2) * r_end * 0.7

          stroke(hue, saturation - 10, brightness + 10, 80)
          line(x2, y2, bx1, by1)
          line(x2, y2, bx2, by2)
          stroke(hue, saturation, brightness, 60)
        end
      end

      line(x1, y1, x2, y2)
    end
  end

  fill(190, 60, 75)
  noStroke
  ellipse(0, 0, 4, 4)

  pop
end
