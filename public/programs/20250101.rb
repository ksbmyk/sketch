# GENUARY 2025 jan1 "Vertical or horizontal lines only."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
end

def draw
    noLoop
    draw_background
end

def draw_background
  (0..height).each do |y|
    gradient = map(abs(y - height / 2), 0, height / 2, 255, 0)
    stroke(lerpColor(color(100, 200, 255), color(255, 150, 60), gradient.to_f / 255))
    line(0, y, width, y)
  end

  100.times do
    stroke(255, 255, 255, rand(50..180))
    y_point = rand((height / 2 + 50)..height)
    x_start = rand(10..height)
    length = rand(5..40)
    line(x_start, y_point, x_start + length, y_point)
  end
end
