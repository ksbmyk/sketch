## Rails Girls Tokyo 16th https://kaigionrails.org/2023 のロゴ design by moegi29

def setup
  createCanvas(700, 700)
  angleMode(DEGREES)
  background(255)
  noLoop
end

def draw
  stroke(0)

  fill('#eeb3b2')
  arc(width/2, height/2, 180, 180, 180, 360)

  fill('#d5e8c5')
  arc(width/2, height/2, 155, 155, 180, 360)
  
  fill('#bca7c7')
  arc(width/2, height/2, 135, 135, 180, 360)
  
  fill('#eeb3b2')
  arc(width/2, height/2, 120, 120, 180, 360)
  
  fill('#d5e8c5')
  arc(width/2, height/2, 110, 110, 180, 360)
  
  fill('#ffffff')
  arc(width/2, height/2, 100, 100, 180, 360)
end
