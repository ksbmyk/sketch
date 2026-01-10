# マウラー・ローズのパラメータ
N = 6
D = 71
TOTAL_POINTS = 361

LINES_PER_FRAME = 3

WOBBLE_AMOUNT = 3
WOBBLE_SPEED = 0.05
TWO_PI = PI * 2

PAUSE_FRAMES = 60

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @current_line = 0
  @radius = width * 0.4
  @drawing_complete = false
  @pause_counter = 0
  @wobble_active = false
  @time = 0.0

  @points_x = []
  @points_y = []
  calculate_maurer_rose_points
end

def draw
  background(230, 80, 8)
  
  if @current_line < TOTAL_POINTS - 1
    @current_line = [@current_line + LINES_PER_FRAME, TOTAL_POINTS - 1].min
  else
    @drawing_complete = true
  end

  if @drawing_complete && !@wobble_active
    @pause_counter += 1
    @wobble_active = true if @pause_counter >= PAUSE_FRAMES
  end

  if @wobble_active
    @time += WOBBLE_SPEED
    @time -= TWO_PI if @time > TWO_PI
  end
  
  push
  translate(width / 2, height / 2)
  
  @current_line.times do |i|
    x1, y1 = wobbled_xy(i)
    x2, y2 = wobbled_xy(i + 1)

    progress = i.to_f / TOTAL_POINTS
    hue = 180 + progress * 80
    
    stroke(hue, 70, 90, 15)
    strokeWeight(6)
    line(x1, y1, x2, y2)

    stroke(hue, 60, 95, 30)
    strokeWeight(3)
    line(x1, y1, x2, y2)

    stroke(hue, 40, 100, 80)
    strokeWeight(1)
    line(x1, y1, x2, y2)
  end
  
  pop
end

def wobbled_xy(index)
  base_x = @points_x[index]
  base_y = @points_y[index]

  return [base_x, base_y] unless @wobble_active

  # 各頂点はインデックスに基づいて一意の位相を持つ（位相は小さく保つ）
  phase_x = (index % 100) * 0.07
  phase_y = (index % 100) * 0.09

  wobble_x = Math.sin(@time + phase_x) * WOBBLE_AMOUNT
  wobble_y = Math.cos(@time + phase_y) * WOBBLE_AMOUNT

  [base_x + wobble_x, base_y + wobble_y]
end

def calculate_maurer_rose_points
  TOTAL_POINTS.times do |i|
    theta_deg = i * D
    theta_rad = radians(theta_deg)
    r = @radius * sin(N * theta_rad)
    @points_x << r * cos(theta_rad)
    @points_y << r * sin(theta_rad)
  end
end
