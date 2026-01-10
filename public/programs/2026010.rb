# マウラー・ローズ
N = 6
D = 71
TOTAL_POINTS = 361

LINES_PER_FRAME = 3

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @current_line = 0
  @radius = width * 0.4
  @points = calculate_maurer_rose_points
end

def draw
  background(230, 80, 8)
  
  if @current_line < TOTAL_POINTS - 1
    @current_line = [@current_line + LINES_PER_FRAME, TOTAL_POINTS - 1].min
  end
  
  push
  translate(width / 2, height / 2)
  
  (0...@current_line).each do |i|
    p1 = @points[i]
    p2 = @points[i + 1]
    
    progress = i.to_f / TOTAL_POINTS
    hue = 180 + progress * 80
    
    stroke(hue, 70, 90, 15)
    strokeWeight(6)
    line(p1[:x], p1[:y], p2[:x], p2[:y])
    
    stroke(hue, 60, 95, 30)
    strokeWeight(3)
    line(p1[:x], p1[:y], p2[:x], p2[:y])
    
    stroke(hue, 40, 100, 80)
    strokeWeight(1)
    line(p1[:x], p1[:y], p2[:x], p2[:y])
  end
  
  pop
end

def calculate_maurer_rose_points
  points = []
  
  TOTAL_POINTS.times do |i|
    # マーラージ曲線：d度の間隔で点を取得
    theta_deg = i * D
    theta_rad = radians(theta_deg)
    
    # ローズ・カーブ
    r = @radius * sin(N * theta_rad)
    
    # 極座標を直交座標に変換
    x = r * cos(theta_rad)
    y = r * sin(theta_rad)
    
    points << { x: x, y: y }
  end
  
  points
end