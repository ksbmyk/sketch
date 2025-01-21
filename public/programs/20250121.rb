# GENUARY 2025 jan21 "Create a collision detection system (no libraries allowed)."
# https://genuary.art/prompts

THRESHOLD = 100 # 線を引く距離の閾値
MAX_SPEED = 3   # 速度の上限
ACCELERATION_FACTOR = 0.5
DECELERATION_FACTOR = 0.99

def setup
  createCanvas(600, 600)
  
  circle_count = 40
  @circles = circle_count.times.map do
    {
      x: rand(0..width),
      y: rand(0..height),
      diameter: rand(10..30),
      speed_x: rand(-3..3) + 0.1,
      speed_y: rand(-3..3) + 0.1
    }
  end
end

def draw
  background(255)
  draw_lines_between_circles
  update_circles
end

# 円同士を線で結ぶ
def draw_lines_between_circles
  stroke(255)
  strokeWeight(1)
  @circles.combination(2).each do |circle1, circle2|
    dx = circle1[:x] - circle2[:x]
    dy = circle1[:y] - circle2[:y]
    distance = sqrt(dx**2 + dy**2)
    color_value = map(distance, 0, THRESHOLD, 255, 100)
    stroke(color_value, 255 - color_value, 255)
    line(circle1[:x], circle1[:y], circle2[:x], circle2[:y]) if distance < THRESHOLD
  end
end

# 各円の位置と速度を更新
def update_circles
  @circles.each_with_index do |circle, i|
    move_circle(circle)
    handle_collisions(circle, i)
    handle_boundaries(circle)
    limit_speed(circle)
    draw_circle(circle)
  end
end

# 円の位置を速度に基づいて更新
def move_circle(circle)
  circle[:x] += circle[:speed_x]
  circle[:y] += circle[:speed_y]
end

# 他の円との衝突を処理
def handle_collisions(circle, index)
  @circles.each_with_index do |other, j|
    next if index == j # 自分自身との比較をスキップ

    dx = circle[:x] - other[:x]
    dy = circle[:y] - other[:y]
    distance = sqrt(dx**2 + dy**2)
    min_dist = (circle[:diameter] + other[:diameter]) / 2

    next unless distance < min_dist # 衝突した場合のみ処理

    angle = atan2(dy, dx)
    target_x = other[:x] + cos(angle) * min_dist
    target_y = other[:y] + sin(angle) * min_dist

    ax = (target_x - circle[:x]) * ACCELERATION_FACTOR
    ay = (target_y - circle[:y]) * ACCELERATION_FACTOR

    circle[:speed_x] += ax
    circle[:speed_y] += ay
  end
end

# 円が画面の端に衝突した際の反射処理
def handle_boundaries(circle)
  if circle[:x] - circle[:diameter] / 2 < 0 || circle[:x] + circle[:diameter] / 2 > width
    circle[:speed_x] *= -1
  end

  if circle[:y] - circle[:diameter] / 2 < 0 || circle[:y] + circle[:diameter] / 2 > height
    circle[:speed_y] *= -1
  end
end

# 速度を上限値に制限
def limit_speed(circle)
  speed_magnitude = sqrt(circle[:speed_x]**2 + circle[:speed_y]**2)
  return if speed_magnitude <= MAX_SPEED

  ratio = MAX_SPEED / speed_magnitude
  circle[:speed_x] *= ratio
  circle[:speed_y] *= ratio
end

# 円を描画
def draw_circle(circle)
  fill(0, 0, 255, 100)
  noStroke
  ellipse(circle[:x], circle[:y], circle[:diameter])
end
