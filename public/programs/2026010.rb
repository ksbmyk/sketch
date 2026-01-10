# マウラー・ローズのパラメータ
N = 6
D = 71
TOTAL_POINTS = 361

WOBBLE_AMOUNT = 3
WOBBLE_SPEED = 0.05
TWO_PI = PI * 2

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @radius = width * 0.4
  @time = 0.0

  @points_x = []
  @points_y = []
  calculate_maurer_rose_points
end

def draw
  background(230, 80, 8)
  
  @time += WOBBLE_SPEED
  @time -= TWO_PI if @time > TWO_PI
  
  push
  translate(width / 2, height / 2)
  
  (TOTAL_POINTS - 1).times do |i|
    x1, y1 = wobbled_xy(i)
    x2, y2 = wobbled_xy(i + 1)

    progress = i.to_f / TOTAL_POINTS
    hue = 180 + progress * 50

    stroke(hue, 90, 100, 4)
    strokeWeight(20)
    line(x1, y1, x2, y2)
    
    stroke(hue, 85, 100, 8)
    strokeWeight(14)
    line(x1, y1, x2, y2)

    stroke(hue, 80, 100, 12)
    strokeWeight(10)
    line(x1, y1, x2, y2)

    stroke(hue, 75, 100, 20)
    strokeWeight(6)
    line(x1, y1, x2, y2)

    stroke(hue, 70, 100, 35)
    strokeWeight(3)
    line(x1, y1, x2, y2)

    stroke(hue, 60, 100, 90)
    strokeWeight(1)
    line(x1, y1, x2, y2)
  end
  
  pop
end

def wobbled_xy(index)
  base_x = @points_x[index]
  base_y = @points_y[index]

  # 各頂点はインデックスに基づいて一意の位相を持つ（位相は小さく保つ）
  phase_x = (index % 100) * 0.07
  phase_y = (index % 100) * 0.09

  wobble_x = sin(@time + phase_x) * WOBBLE_AMOUNT
  wobble_y = cos(@time + phase_y) * WOBBLE_AMOUNT

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
