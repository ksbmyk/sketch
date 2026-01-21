def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100)
  noLoop
end

def draw
  background(220, 30, 15)
  noStroke
  
  # 不均一なグリッドの行・列幅を生成
  cols = generate_divisions(700, 8, 12)
  rows = generate_divisions(700, 8, 12)
  
  center_x = 350
  center_y = 350
  max_dist = Math.sqrt(center_x**2 + center_y**2)
  
  x = 0
  cols.each do |col_width|
    y = 0
    rows.each do |row_height|
      cell_center_x = x + col_width / 2.0
      cell_center_y = y + row_height / 2.0

      dist = Math.sqrt((cell_center_x - center_x)**2 + (cell_center_y - center_y)**2)
      normalized_dist = dist / max_dist

      hue = 180 + normalized_dist * 90
      saturation = 40 + normalized_dist * 35
      brightness = 85 - normalized_dist * 45
      hue += randomGaussian * 8
      saturation += randomGaussian * 5
      brightness += randomGaussian * 5
      
      fill(hue, saturation, brightness)
      rect(x, y, col_width, row_height)
      
      y += row_height
    end
    x += col_width
  end
end

# 不均一な幅に分割
def generate_divisions(total_size, min_count, max_count)
  count = rand(min_count..max_count)

  ratios = count.times.map { rand(0.5..1.5) }
  sum = ratios.sum

  ratios.map { |r| (r / sum * total_size).round }
end
