# 資料では使わず
def setup
  createCanvas(600, 600)
  angleMode(DEGREES)
  frameRate(5)
end

def draw
  background('#ffffff')
  translate(300, 300)
  noStroke

  fill('#1da1f2')
  ellipse(0, 0, 150, 110)

  if frameCount.to_i.even?
    arc(-30, -20 , 200, 110,  90,  180)
    arc(30, -20 , 200, 110,  0,  90)
  else
    push
    rotate(10, 10)
    arc(-30, -20 , 200, 110,  90,  180)
    pop
    push
    rotate(-10, -10)
    arc(30, -20 , 200, 110,  0,  90)
    pop
  end

  fill('#ffffff')
  ellipse(-23, -15, 5, 10)
  ellipse(23, -15, 5, 10)
end
