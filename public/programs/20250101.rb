# GENUARY 2025 jan1 "Vertical or horizontal lines only."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  noLoop
end

def draw
    draw_background
end

def draw_background
  (0..height).each do |y|
    if y.odd?
      gradient = map(abs(y - height / 2), 0, height / 2, 255, 0)
      stroke(lerpColor(color(0, 120, 255), color(0, 0, 255), gradient.to_f / 255))
      line(0, y, width, y)
    end
  end
  stroke("#ffffff")
  50.times do
    x_point = rand(0..height)
    y_start = rand(10..height)
    length = rand(10..100)
    line(x_point, y_start, x_point, y_start + length)
  end
end
