# GENUARY 2025 jan22 "Generative Architecture."
# https://genuary.art/prompts

def setup
  createCanvas(600, 600)
  noLoop
end

def draw
  colors = [
    color(100, 255, 255),
    color(100, 100, 255),
    color(255, 200, 100),
    color(100, 100, 255)
  ]

  3.times do |i|
    set_gradient(0, i * height / 3, width, height / 3, colors[i], colors[(i + 1) % 3])
  end
end

def set_gradient(x, y, w, h, c1, c2)
  noFill
  (0..h.to_i).each do |i|
    inter = map(i, 0, h, 0, 1)
    c = lerpColor(c1, c2, inter)
    stroke(c)
    line(x, y + i, x + w, y + i)
  end
end
