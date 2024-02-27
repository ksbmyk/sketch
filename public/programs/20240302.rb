## Rails Girls Tokyo 16th https://kaigionrails.org/2023 のロゴ design by moegi29

def setup
  createCanvas(700, 700)
  angleMode(DEGREES)
  background(255)
  noLoop
end

def draw
  bridge = Proc.new do |options|
    stroke(0)
    fill(options[:color])
    arc(width/2, height/2, options[:size], options[:size], 180, 360)
  end

  colors = ['#eeb3b2', '#d5e8c5', '#bca7c7']
  radius = 210

  5.times do |i|
    color = colors[i % colors.length]
    options = { color: color, size: radius }
    bridge.call(options)
    radius = radius - (- 5*i + 30)
  end
  
  options = { color: '#ffffff', size: 110 }
  bridge.call(options) 
end
