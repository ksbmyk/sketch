## Rails Girls Tokyo 16th https://kaigionrails.org/2023 のロゴ design by moegi29

def setup
  createCanvas(700, 700)
  angleMode(DEGREES)
  background(255)
  noLoop
end

def draw

  bridge = Proc.new do |color, size|
    stroke(0)
    fill(color)
    arc(width/2, height/2, size, size, 180, 360)
  end

  colors = ['#eeb3b2', '#d5e8c5', '#bca7c7']
  radius = 210

  5.times do |i|
    color = colors[i % colors.length]
    bridge.call(color, radius)
    radius = radius - (- 5*i + 30)
  end
  bridge.call('#ffffff', 110) 
end
