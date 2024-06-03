# #minacoding 2024 June 3 "Image"
# https://minacoding.online/theme

def preload
  @img = loadImage('https://ksbmyk.github.io/sketch/images/20240101.png')
end

def setup
  createCanvas(700, 700)
  noStroke
  background(255)
  image(@img, 0, 0)
  @img.loadPixels()
end

def draw
  x = 0
  while width > x do
    y =  0
    while height > y do
      r = rand(5..10)
      pix = @img.get(x, y)
      fill(pix, 128)
      ellipse(x, y, r)
      y = y + r
    end
    x = x + r
  end
end
