# Recursive Pattern
# 第一回ジェネラティブアート・アワード 応募作品 https://generativeart.or.jp/generative-art-award

def setup
  createCanvas(600, 600)
  frameRate(0.5)
  colorMode(HSB, 360, 100, 100)
  noLoop # 重いのでこのサイトでは繰り返し描画しない
end

def draw
  colors = set_color
  background(colors[:background])
  noFill

  draw_pattern(colors[:stroke1], 5)
  draw_pattern(colors[:stroke2], 2)
end

def draw_pattern(color, weight)
  stroke(color)
  strokeWeight(weight)
  (0..8).each do |i|
    (0..8).each do |j|
      geometric(80 * i, 80 * j, 100, rand(3..5), rand(1..6))
    end
  end
end

def geometric(x, y, radius, depth, num_sides)
  return if depth.zero?
  
  beginShape
  num_sides.times do |i|
    angle = map(i, 0, num_sides, 0, TWO_PI)
    x_offset = x + cos(angle) * radius
    y_offset = y + sin(angle) * radius
    vertex(x_offset, y_offset)
    
    next_radius = radius * 0.3
    next_x = x + cos(angle) * next_radius
    next_y = y + sin(angle) * next_radius
    geometric(next_x, next_y, next_radius, depth - 1, num_sides)
  end
  endShape(CLOSE)
end

def set_color
  base_hue = rand(0..360)
  saturation = 80
  brightness = 90
  
  {
    background: color(base_hue, saturation, brightness),
    stroke1: color((base_hue + 30) % 360, saturation, brightness - 50),
    stroke2: color((base_hue - 30 + 360) % 360, saturation, brightness)
  }
end
