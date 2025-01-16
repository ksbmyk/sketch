def setup
  createCanvas(600, 600)
  colorMode(HSB, 360, 100, 100, 100)
  noStroke
  frameRate(0.5)
  @previous_color = nil
end

def draw
  colors = set_color(@previous_color)
  background(colors[:background])
  
  rows = 10
  cols = 10
  size = width / cols

  rows.times do |y|
    cols.times do |x|
      cx = x * size + size / 2
      cy = y * size + size / 2

      if (x + y).even?
        fill(colors[:stroke1])
        ellipse(cx, cy, size * 0.5)
      else
        fill(colors[:stroke2])
        rectMode(CENTER)
        push
        translate(cx, cy)
        rotate((x + y).even? ? 0 : HALF_PI / 2)
        rect(0, 0, size * 0.8, size * 0.8)
        pop
      end
    end
  end
end

def set_color(previous_color = nil)
  base_hue = rand(0..360)
  saturation = rand(10..40)
  brightness = rand(80..100)

  if previous_color
    previous_hue = previous_color[:hue]
    previous_saturation = previous_color[:saturation]
    previous_brightness = previous_color[:brightness]

    until valid_color?(base_hue, saturation, brightness, previous_hue, previous_saturation, previous_brightness)
      base_hue = rand(0..360)
      saturation = rand(10..40)
      brightness = rand(80..100)
    end
  end

  {
    background: color(base_hue, saturation, brightness),
    stroke1: color((base_hue + 15) % 360, saturation + 5, brightness - 10),
    stroke2: color((base_hue - 15) % 360, saturation + 10, brightness - 5),
    hue: base_hue,
    saturation: saturation,
    brightness: brightness
  }
end

def valid_color?(base_hue, saturation, brightness, previous_hue, previous_saturation, previous_brightness)
  hue_diff = (base_hue - previous_hue).abs
  hue_diff = 360 - hue_diff if hue_diff > 180 # 色相の差が180度を超える場合は補正

  hue_diff >= 60 &&
    (saturation - previous_saturation).abs >= 10 &&
    (brightness - previous_brightness).abs >= 10
end
