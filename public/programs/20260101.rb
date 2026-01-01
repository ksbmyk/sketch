# GENUARY 2026 jan1 "One color, one shape."
# https://genuary.art/prompts

def setup
  createCanvas(windowWidth, windowWidth)
  colorMode(HSB, 360, 100, 100, 255)
  noStroke
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
  @hue_value = 100

  @alpha_value = 150

  fill(@hue_value, 80, 100, @alpha_value)
  @speed = 0.05

  @angle_offset += @speed

  @circle_count = 10

  @circle_count.times do |i|
    angle = TWO_PI / @circle_count * i + @angle_offset
    @distance = 100

    x = cos(angle) * @distance
    y = sin(angle) * @distance
    @circle_size = 150

    circle(x, y, @circle_size + (i.even? ? 30 : -30))
  end
end

