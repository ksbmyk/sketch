def setup
  createCanvas(720, 720)
  background(255)
  colorMode(HSB, 360, 100, 100, 100)
  noLoop
end
  
def draw
  size = 10
  noStroke
  10000.times do |i|
    if i < 5000
      fill(200+rand(0..20), 80+rand(0..20), 80, 30)
    else
      fill(100+rand(0..20), 80+rand(0..20), 80, 30)
    end
    rect(rand(0..width - size), rand(0..width - size), size)
  end
  fill(200+rand(0..20), 80+rand(0..20), 80, 100)
  rect(0, 0, width, 10)
  rect(0, 0, 10, height)
  rect(width-10, 0, 10, height)
  rect(0, height-10, width, 10) 
end
  