def setup
  createCanvas(windowWidth, windowWidth)
  colorMode(HSB, 360, 100, 100, 255)
  @angle_offset = 0
  noFill
end

def draw
  blendMode(BLEND)
  @is_dark_mode = true
  if (@is_dark_mode)
    background(0, 0, 0)
    blendMode(ADD)
  else
    background(0, 0, 100)
    blendMode(MULTIPLY)
  end

  translate(width / 2, height / 2)

  @alpha_value = 150
  @speed = 0.04
  @angle_offset += @speed

  @base_hue = (@angle_offset * 20) % 360

  @circle_count = 10

  distance = 100

  # 呼吸
  breath = sin(@angle_offset * 0.5)

  # 線の太さの呼吸
  weight = 6 + breath * 4
  strokeWeight(weight)

  # サイズだけ呼吸（80〜220）
  circle_size = 150 + breath * 70

  @circle_count.times do |i|
    angle = TWO_PI / @circle_count * i + @angle_offset

    x = cos(angle) * distance
    y = sin(angle) * distance

    hue = (@base_hue + i * 15) % 360
    stroke(hue, 80, 100, @alpha_value)

    circle(x, y, circle_size + (i.even? ? 30 : -30))
  end
end
