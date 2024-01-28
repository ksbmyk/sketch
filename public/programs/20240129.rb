# GENUARY 2024 jan29 "Signed Distance Functions (if we keep trying once per year, eventually we will be good at it!)."
# https://genuary.art/prompts

def setup
  createCanvas(720, 720)
  @stepLength = 8
  @angle = 0
  @radius = 0
  background(0)
  blendMode(DIFFERENCE)
  frameRate(5)
end

def draw
  hw = width / 2
  hh = height / 2

  # 今の位置
  p = createVector(hw + @radius * cos(@angle), hh + @radius * sin(@angle))
  # 距離
  dist = sdf(p, 0.05)
  size = max(0.25, 1 - (0.02 - abs(dist)) / 0.02) * 10

  # 円
  fill(random(255), random(255), random(255))
  noStroke
  ellipse(p.x, p.y, size * 2, size * 2)

  # 位置の更新
  @angle += radians(10)
  @radius += @stepLength

  # エッジに達したらリセット
  if (@radius >= width / 2)
    noLoop
  end
end

# 符号付き距離関数
def sdf(p, frequency)
  return sin(p.x * frequency) * cos(p.y * frequency)
end
