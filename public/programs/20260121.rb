# GENUARY 2026 jan21 "Bauhaus Poster."
# https://genuary.art/prompts

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
      # セルの中心座標
      cell_center_x = x + col_width / 2.0
      cell_center_y = y + row_height / 2.0
      
      # キャンバス中心からの距離（0〜1に正規化）
      dist = Math.sqrt((cell_center_x - center_x)**2 + (cell_center_y - center_y)**2)
      normalized_dist = dist / max_dist
      
      # セルのベース色を計算
      base_hue = 180 + normalized_dist * 90
      base_saturation = 40 + normalized_dist * 35
      base_brightness = 85 - normalized_dist * 45
      
      # ガウシアンノイズ
      base_hue += randomGaussian * 8
      base_saturation += randomGaussian * 5
      base_brightness += randomGaussian * 5
      
      # セルごとにグラデーションの強さをランダムに決定（0.2〜1.5）
      gradient_strength = rand(0.2..1.5)

      # セル内グラデーション
      draw_cell_gradient(x, y, col_width, row_height, base_hue, base_saturation, base_brightness, gradient_strength)
      
      y += row_height
    end
    x += col_width
  end
end

def draw_cell_gradient(x, y, w, h, base_hue, base_sat, base_bri, strength)
  steps = 8
  cell_center_x = x + w / 2.0
  cell_center_y = y + h / 2.0
  max_cell_dist = Math.sqrt((w / 2.0)**2 + (h / 2.0)**2)
  
  # 外側から内側へ描画（内側が上に重なる）
  steps.downto(1) do |i|
    t = i / steps.to_f  # 1.0（外側）から 0.125（内側）

    brightness_offset = ((1 - t) * 12 - 6) * strength
    saturation_offset = ((1 - t) * -8 + 4) * strength
    
    fill(base_hue, base_sat + saturation_offset, base_bri + brightness_offset)

    inset_x = w * (1 - t) / 2.0
    inset_y = h * (1 - t) / 2.0
    rect(x + inset_x, y + inset_y, w * t, h * t)
  end
end

# 不均一な幅に分割
def generate_divisions(total_size, min_count, max_count)
  count = rand(min_count..max_count)

  ratios = count.times.map { rand(0.5..1.5) }
  sum = ratios.sum
  
  ratios.map { |r| (r / sum * total_size).round }
end
