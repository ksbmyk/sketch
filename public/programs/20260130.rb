def setup
  createCanvas(700, 700)
  frameRate(8)
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
  
  # 20フレームに3フレームは正常表示
  normal_frame = (frameCount % 20) < 3
  
  @segments.each do |seg|
    high_density = seg[:density] > 2
    
    if high_density
      unless normal_frame
        # 密度が高い場所は60%の確率で欠落
        next if rand < 0.6
      end
      
      # 交差点付近は明るいシアン
      stroke(180, 90, 100, 95)
      strokeWeight(2.5)
    else
      # 正常部分は暗めの青紫
      stroke(seg[:hue], 40, 40, 60)
      strokeWeight(1)
    end
    
    line(seg[:x1], seg[:y1], seg[:x2], seg[:y2])
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
