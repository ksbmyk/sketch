def setup
  createCanvas(700, 700)
  noLoop
  colorMode(HSB, 360, 100, 100, 100)
  rectMode(CENTER)
end

def draw
  background(220, 80, 10)
  
  grid_size = 15
  cell_size = width.to_f / grid_size
  base_square_size = cell_size * 0.9
  
  center_x = width / 2.0
  center_y = height / 2.0
  max_dist = Math.sqrt(center_x**2 + center_y**2)
  
  grid_size.times do |i|
    grid_size.times do |j|
      x = (i + 0.5) * cell_size
      y = (j + 0.5) * cell_size
      
      dist = Math.sqrt((x - center_x)**2 + (y - center_y)**2)
      disorder = (dist / max_dist) ** 3
      
      # 位置のずれ
      offset_range = cell_size * 0.4 * disorder
      offset_x = random(-offset_range, offset_range)
      offset_y = random(-offset_range, offset_range)
      
      # サイズの変化
      size_variation = 1.0 + random(-0.5, 0.5) * disorder
      square_size = base_square_size * size_variation
      
      # 回転
      rotation_range = PI * disorder
      angle = random(-rotation_range, rotation_range)

      hue = 210
      saturation = 70
      brightness = 80 - disorder * 50
      
      fill(hue, saturation, brightness, 80)
      noStroke
      
      push
      translate(x + offset_x, y + offset_y)
      rotate(angle)
      rect(0, 0, square_size, square_size)
      pop
    end
  end
end
