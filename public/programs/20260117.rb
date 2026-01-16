def setup
  createCanvas(700, 700)
  noLoop
  colorMode(HSB, 360, 100, 100, 100)
end

def draw
  background(220, 80, 15)
  
  hex_radius = 80
  
  col_width = hex_radius * 1.2
  row_height = hex_radius
  
  (-row_height).step(to: height + row_height * 2, by: row_height).each_with_index do |cy, row|
    y_offset = row.odd? ? 0 : col_width / 2.0
    
    (-col_width).step(to: width + col_width * 2, by: col_width).each do |base_x|
      cx = base_x + y_offset
      draw_mirror_cell(cx, cy, hex_radius)
    end
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
      c, s = cos(angle), sin(angle)

      if i.even?
        x1, y1 = c * r_start * 0.3, s * r_start * 0.3
        x2, y2 = c * r_end, s * r_end
      else
        x1, y1 = c * r_start * 0.5, s * r_start * 0.5
        x2, y2 = c * r_end * 0.9, s * r_end * 0.9

        if layer.even?
          stroke(hue, saturation - 10, brightness + 10, 80)
          [-1, 1].each do |dir|
            ba = angle + dir * PI / 12
            line(x2, y2, cos(ba) * r_end * 0.7, sin(ba) * r_end * 0.7)
          end
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
