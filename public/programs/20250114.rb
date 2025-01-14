def setup
  createCanvas(700, 700)
  noStroke
  frameRate(10)
end

def draw
  background(255)
  100.times do
    fill(rand > 0.5 ? 0 : 255)
    x1 = rand(width)
    y1 = rand(height)
    x2 = x1 + rand(-100..100)
    y2 = y1 + rand(-100..100)
    x3 = x1 + rand(-100..100)
    y3 = y1 + rand(-100..100)
    triangle(x1, y1, x2, y2, x3, y3)
  end
end
