def setup
  createCanvas(700, 700)
  frameRate(12)
  colorMode(HSB, 360, 100, 100, 100)
  
  @radius = width * 0.35
  
  # 3つのマウラーローズのパラメータ
  @roses = [
    { n: 5, d: 97, hue: 190 },
    { n: 6, d: 71, hue: 215 },
    { n: 7, d: 53, hue: 240 }
  ]
  
  # 各ローズの線分を事前計算
  @segments = []
  @roses.each do |rose|
    361.times do |i|
      next if i == 0
      
      theta1 = radians((i - 1) * rose[:d])
      r1 = @radius * sin(rose[:n] * theta1)
      x1 = r1 * cos(theta1)
      y1 = r1 * sin(theta1)
      
      theta2 = radians(i * rose[:d])
      r2 = @radius * sin(rose[:n] * theta2)
      x2 = r2 * cos(theta2)
      y2 = r2 * sin(theta2)
      
      @segments << {
        x1: x1, y1: y1,
        x2: x2, y2: y2,
        hue: rose[:hue]
      }
    end
  end
  
  # グリッドで線分密度を計算
  @grid_size = 25
  @density = calculate_density
  
  # 各線分の密度を事前計算
  @segments.each do |seg|
    mid_x = (seg[:x1] + seg[:x2]) / 2.0
    mid_y = (seg[:y1] + seg[:y2]) / 2.0
    seg[:density] = get_density(mid_x, mid_y)
  end
end

def draw
  background(230, 60, 10)
  translate(width / 2, height / 2)
  
  @segments.each do |seg|
    density = seg[:density]

    # 密度に応じて分割数を決める
    num_parts = density <= 2 ? 1 : [density - 1, 6].min
    
    # 線分を分割して描画
    draw_broken_line(seg, num_parts, density)
  end
end

def draw_broken_line(seg, num_parts, density)
  x1, y1 = seg[:x1], seg[:y1]
  x2, y2 = seg[:x2], seg[:y2]

  if num_parts == 1
    # 密度が低い：普通に描画（少しだけ太さにブレ）
    stroke(seg[:hue], 50, 70, 80)
    strokeWeight(1.5 + rand * 0.3)
    line(x1, y1, x2, y2)
  else
    # 密度が高い：断続的に描画 + 太さが不安定
    num_parts.times do |i|
      next if rand < 0.4
      
      t_start = i.to_f / num_parts
      t_end = (i + 1).to_f / num_parts

      t_start += 0.05
      t_end -= 0.05
      next if t_start >= t_end

      px1 = x1 + (x2 - x1) * t_start
      py1 = y1 + (y2 - y1) * t_start
      px2 = x1 + (x2 - x1) * t_end
      py2 = y1 + (y2 - y1) * t_end

      brightness = 60 + density * 5
      stroke(seg[:hue] + rand(-10..10), 70, brightness, 85)

      # 密度が高いほど太さの変動幅が大きい
      weight_variation = density * 0.8
      weight = 1.0 + rand * weight_variation
      # たまに極端に太くなる「バグ」
      weight *= 3 if rand < 0.05
      strokeWeight(weight)

      line(px1, py1, px2, py2)
    end
  end
end

def calculate_density
  grid_count = (@radius * 2 / @grid_size).ceil + 1
  density = Array.new(grid_count) { Array.new(grid_count, 0) }
  
  @segments.each do |seg|
    mid_x = (seg[:x1] + seg[:x2]) / 2.0
    mid_y = (seg[:y1] + seg[:y2]) / 2.0
    
    gx = ((mid_x + @radius) / @grid_size).floor
    gy = ((mid_y + @radius) / @grid_size).floor
    
    next if gx < 0 || gy < 0 || gx >= grid_count || gy >= grid_count
    
    density[gx][gy] += 1
  end
  
  density
end

def get_density(x, y)
  gx = ((x + @radius) / @grid_size).floor
  gy = ((y + @radius) / @grid_size).floor
  
  return 0 if gx < 0 || gy < 0 || gx >= @density.length || gy >= @density[0].length
  
  @density[gx][gy]
end
