$min = 50
$size = 200
def setup
  createCanvas(200, 200)
  background(0)
  rectMode(CENTER)
  noStroke
  #noLoop
  blendMode(SCREEN)
  frameRate(2)
end

def draw
  blendMode(BLEND)
  background(0)
  blendMode(SCREEN) 
  x = width/2
  y = height/2
  alpha = rand(50..255)
  color = rand(0..255)
  fill(0, color, 255, alpha)
  ellipse(x, y , rand($min..$size) * 0.8)
  push
  translate(x,y)
  rotate(PI / 4)
  rect(0, 0, rand($min..$size) * 0.7)
  pop
  rect(x, y, rand($min..$size) * 0.5)
  ellipse(x, y , rand($min..$size)*0.3)
end
