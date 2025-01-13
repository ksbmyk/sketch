def setup
  createCanvas(700, 700)
  noStroke
end

def draw
  background(0)
  rows = 12
  cols = 12
  size = width / cols

  rows.times do |y|
    cols.times do |x|
      h = sin(frameCount * 0.02 + (x + y) * 0.1) * 50
      fill(100, 200, map(h, -50, 50, 0, 255))

      # x * size, y * size,
      # x * size + size / 2, y * size + h,
      # x * size + size, y * size
      triangle(x * size, y * size, x * size + size / 2, y * size + h, x * size + size, y * size)
    end
  end
end
