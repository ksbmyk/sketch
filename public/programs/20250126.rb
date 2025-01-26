# GENUARY 2025 jan26 "Symmetry."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  background(0)
  blendMode(ADD)
  noStroke

  500.times do
    x1 = rand(50..width - 50)
    y1 = rand(50..height - 50)
    x2 = x1 + rand(-50..50)
    y2 = y1 + rand(-50..50)
    x3 = x1 + rand(-50..50)
    y3 = y1 + rand(-50..50)

    fill(rand(50..255), rand(50..150), rand(200..255), 100)
    triangle(x1, y1, x2, y2, x3, y3)

    fill(rand(200..255), rand(50..100), rand(100..150), 100)
    triangle(width - x1, y1, width - x2, y2, width - x3, y3)
  end
end
