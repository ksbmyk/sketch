# マウラー・ローズ
N = 6
D = 71
TOTAL_POINTS = 361

LINES_PER_FRAME = 3

WOBBLE_AMOUNT = 3
WOBBLE_SPEED = 0.05
TWO_PI = Math::PI * 2

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @current_line = 0
  @radius = width * 0.4
  @drawing_complete = false
  @time = 0.0

  @points = calculate_maurer_rose_points
end

def draw
  background(230, 80, 8)
  
  if @current_line < TOTAL_POINTS - 1
    @current_line = [@current_line + LINES_PER_FRAME, TOTAL_POINTS - 1].min
  else
    @drawing_complete = true
  end

  if @drawing_complete
    @time += WOBBLE_SPEED
    @time -= TWO_PI if @time > TWO_PI
  end
  
  push
  translate(width / 2, height / 2)
  
  @current_line.times do |i|
    p1 = wobbled_point(i)
    p2 = wobbled_point(i + 1)
    
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

def wobbled_point(index)
  base = @points[index]

  return base unless @drawing_complete

  # 各頂点はインデックスに基づいて一意の位相を持つ（位相は小さく保つ）
  phase_x = (index % 100) * 0.07
  phase_y = (index % 100) * 0.09

  wobble_x = sin(@time + phase_x) * WOBBLE_AMOUNT
  wobble_y = cos(@time + phase_y) * WOBBLE_AMOUNT

  { x: base[:x] + wobble_x, y: base[:y] + wobble_y }
end

def calculate_maurer_rose_points
  points = []
  
  TOTAL_POINTS.times do |i|
    theta_deg = i * D
    theta_rad = radians(theta_deg)
    r = @radius * sin(N * theta_rad)
    x = r * cos(theta_rad)
    y = r * sin(theta_rad)
    points << { x: x, y: y }
  end
  
  points
end
