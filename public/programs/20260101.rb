# GENUARY 2026 jan1 "One color, one shape."
# https://genuary.art/prompts
def setup
  createCanvas(windowWidth, windowWidth)
  colorMode(HSB, 360, 100, 100, 255)
  @angle_offset = 0
end

def draw
  blendMode(BLEND)
  @is_dark_mode = false
  if (@is_dark_mode)
    background(0, 0, 0)
    blendMode(ADD)
  else
    background(0, 0, 100)
    blendMode(MULTIPLY)
  end

  translate(width / 2, height / 2)

  @alpha_value = 150
  @speed = 0.05
  @angle_offset += @speed

  # 時間で色相を変化（0〜360をループ）
  @base_hue = (@angle_offset * 20) % 360

  @circle_count = 10

  @circle_count.times do |i|
    angle = TWO_PI / @circle_count * i + @angle_offset
    @distance = 100

    x = cos(angle) * @distance
    y = sin(angle) * @distance

    # 各円で色相をずらしてグラデーション
    hue = (@base_hue + i * 15) % 360
    stroke(hue, 80, 100, @alpha_value)

    # strokeWeightを動的に変化（1〜6の範囲）
    weight = 3 + sin(@angle_offset + i * 0.5) * 2
    strokeWeight(weight)

    @circle_size = 150
    circle(x, y, @circle_size + (i.even? ? 30 : -30))
  end
end
