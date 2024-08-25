# #minacoding 2024 June 5 "Many"
# https://minacoding.online/theme

def setup
  createCanvas(400, 400)
  background(255)
  noLoop
  noStroke
end

def draw
  background(0)
  
  g = 0
  step = 1
  x = width / 2
  y = height / 2
  d = 10
  
  1000.times do
    fill(0, g, 255)
    ellipse(x, y, d)
    choice = rand(0..3)
    case choice
    when 0
      x += d 
    when 1
      x -= d 
    when 2
      y += d 
    else
      y -= d 
    end

    g += step
    step *= -1 if g >= 255 || g <= 0
  end
end
