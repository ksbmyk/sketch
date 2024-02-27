## Rails Girls Tokyo 16th https://kaigionrails.org/2023 のロゴ design by moegi29

def setup
  createCanvas(700, 700)
  angleMode(DEGREES)
  background(255)
  noLoop
end

def draw
  stroke(0)

  bridge('#eeb3b2', 180)
  bridge('#d5e8c5', 155)
  bridge('#bca7c7', 135)
  bridge('#eeb3b2', 120)
  bridge('#d5e8c5', 110)
  bridge('#ffffff', 100)  
end

def bridge(color, size)
  fill(color)
  arc(width/2, height/2, size, size, 180, 360)
end
