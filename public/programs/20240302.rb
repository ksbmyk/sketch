## Rails Girls Tokyo 16th https://kaigionrails.org/2023 のロゴ design by moegi29

def setup
  createCanvas(700, 700)
  angleMode(DEGREES)
  background(255)
  noLoop
end

def draw
  stroke(0)
  colors = ['#eeb3b2', '#d5e8c5', '#bca7c7']
  radius = 210
  5.times do |i|
    bridge('#eeb3b2', radius)
    puts radius.to_s
    radius = radius - (- 5*i + 30)
  end
  bridge('#ffffff', 110)  
end

def bridge(color, size)
  fill(color)
  arc(width/2, height/2, size, size, 180, 360)
end
