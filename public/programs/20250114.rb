def setup
  createCanvas(400, 400)
  noStroke
  frameRate(10)
end

def draw
  background(255)
  100.times do
    fill(rand > 0.5 ? 0 : 255)
    x1 = rand(width)
    y1 = rand(height)
    x2 = x1 + rand(-50..50)
    y2 = y1 + rand(-50..50)
    x3 = x1 + rand(-50..50)
    y3 = y1 + rand(-50..50)
    triangle(x1, y1, x2, y2, x3, y3)
  end
end
