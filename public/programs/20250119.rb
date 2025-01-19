def setup
  createCanvas(600, 600)
  noStroke
end

def draw
  background(0)
  cols = 10
  rows = cols
  size = width / cols

  rows.times do |y|
    cols.times do |x|
      fill(255)
      offset = sin(frameCount * 0.05 + (x + y) * 0.5) * 10
      rect(x * size + offset, y * size + offset, size - 10, size - 10)
    end
  end
end
