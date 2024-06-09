# #minacoding 2024 June 6 "Morning"
# https://minacoding.online/theme

$size = 50
def setup
  createCanvas(700, 700)
  noStroke
  noLoop
end

def draw
  x = 0
  while x < width do
    y = 0
    while y < height do
      alpha = map(y, 0, height, 50, 255)
      fill(100, 150, 200, alpha)
      ellipse(x + $size / 2, y + $size / 2, 10)
      y += $size 
    end
    x += $size
  end
end 
