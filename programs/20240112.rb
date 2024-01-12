# GENUARY 2024 jan12 "Lava lamp."
# https://genuary.art/prompts


def setup
  createCanvas(600, 600)
  
  circle_count = 10
  @circles = []
  circle_count.times do
    @circles << {
      x: rand(0..width),
      y: rand(0..height),
      diameter: rand(20..50),
      speed_x: rand(-1..1) + 0.1,
      speed_y: rand(-1..1) + 0.1,
    }
  end
end

def draw
  background(0)
  
  @circles.each_with_index do |circle, i|
    circle[:x] += circle[:speed_x]
    circle[:y] += circle[:speed_y]

    # ぶつかり判定
    collided = true

    (0...@circles.length).each do |j| # 他の円すべて
      if (i != j)
        other = @circles[j] # 他の円

        # 円同士の距離を計算
        dx = circle[:x] - other[:x]
        dy = circle[:y] - other[:y]
        distance = sqrt(dx * dx + dy * dy) # 2つの円の中心間の距離
        min_dist = circle[:diameter] / 2 + other[:diameter] / 2 # 円同士が衝突するための最小の距離

        # 円同士がぶつかったとき
        if (distance < min_dist)
          collided = true
          # atan2 直角三角形の、斜辺でない2辺の長さから、x軸との角度をとる
          angle = atan2(dy, dx) # ぶつかった方向を計算

          target_x = other[:x] + cos(angle) * min_dist # 衝突時の目標x座標を計算
          target_y = other[:y] + sin(angle) * min_dist # 衝突時の目標y座標を計算
          ax = (target_x - circle[:x]) * 0.1 # 加速度（x方向）を計算
          ay = (target_y - circle[:y]) * 0.1 # 加速度（y方向）を計算
          circle[:speed_x] += ax # x方向の速度を更新
          circle[:speed_y] += ay # y方向の速度を更新
        end
      end
    end

    # 左右の端とぶつかったら
    if ((circle[:x] - circle[:diameter] / 2 < 0) || (circle[:x] + circle[:diameter] / 2 > width))
      circle[:speed_x] *= -1 # 速度を反転
    end
    # 上下の端とぶつかったら
    if ((circle[:y] - circle[:diameter] / 2 < 0) || (circle[:y] + circle[:diameter] / 2 > height))
      circle[:speed_y] *= -1 # 速度を反転
    end

    # ぶつからなかったらゆっくりにする
    unless collided
      circle[:speed_x] *= 0.99
      circle[:speed_y] *= 0.99
    end

    # 速度上限を設けてどんどん速くならないようにする
    max_speed = 2
    # 円の現在の速度の大きさを計算
    # sqrt 平方根 速度の大きさ（ベクトルの長さ）をとる
    speed_magnitude = sqrt(circle[:speed_x] ** 2 + circle[:speed_y] ** 2)
    if (speed_magnitude > max_speed)
      ratio = max_speed / speed_magnitude
      circle[:speed_x] *= ratio
      circle[:speed_y] *= ratio
    end

    fill("#32f8fd")
    noStroke
    ellipse(circle[:x], circle[:y], circle[:diameter])
  end
end
