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
  
  # 円同士の衝突処理と速度制限の追加
  @circles.each_with_index do |circle, i|
    circle[:x] += circle[:speed_x]
    circle[:y] += circle[:speed_y]

    (0...@circles.length).each do |j|
      if (i != j)
        other = @circles[j]

        dx = circle[:x] - other[:x]
        dy = circle[:y] - other[:y]
        distance = sqrt(dx * dx + dy * dy)

        minDist = circle[:diameter] / 2 + other[:diameter] / 2

        if (distance < minDist)
          angle = atan2(dy, dx)

          targetX = other[:x] + cos(angle) * minDist
          targetY = other[:y] + sin(angle) * minDist
          ax = (targetX - circle[:x]) * 0.1
          ay = (targetY - circle[:y]) * 0.1
          circle[:speed_x] += ax
          circle[:speed_y] += ay
        end
      end
    end

    if ((circle[:x] - circle[:diameter] / 2 < 0) || (circle[:x] + circle[:diameter] / 2 > width))
      circle[:speed_x] *= -1
    end
    if ((circle[:y] - circle[:diameter] / 2 < 0) || (circle[:y] + circle[:diameter] / 2 > height))
      circle[:speed_y] *= -1
    end

    maxSpeed = 2 # 上限速度
    speedMagnitude = sqrt(circle[:speed_x] ** 2 + circle[:speed_y] ** 2)
    if (speedMagnitude > maxSpeed)
      ratio = maxSpeed / speedMagnitude
      circle[:speed_x] *= ratio
      circle[:speed_y] *= ratio
    end

    fill(255)
    noStroke()
    ellipse(circle[:x], circle[:y], circle[:diameter])
  end
end
