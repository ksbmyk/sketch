# esa https://esa.io/ のﾄﾘ(\( ⁰⊖⁰)/) design by ken_c_lo
def setup
  createCanvas(600, 600)
  angleMode(DEGREES)
  frameRate(10)
end

def draw
  background('#0a9b94')
  translate(300, 300)
  noStroke

  # 顔
  fill(255)
  ellipse(0, 0, 100, 108)

  # 羽
  if frameCount.to_i.even?
    arc(-30, -20 , 110, 110,  90,  180)
    arc(30, -20 , 110, 110,  0,  90)
  else
    push
    rotate(10, 10)
    arc(-30, -20 , 110, 110,  90,  180)
    pop
    push
    rotate(-10, -10)
    arc(30, -20 , 110, 110,  0,  90)
    pop
  end

  # 目
  fill('#666666')
  ellipse(-23, -15, 15, 20)
  ellipse(23, -15, 15, 20)
  # ハイライト
  fill(255)
  ellipse(-23, -15, 5, 10)
  ellipse(23, -15, 5, 10)

  # 口
  fill('#e79012')
  circle(0, 0, 30)
  strokeWeight(5)
  stroke('#a67b3c')
  line(-9, 0, 9, 0)
end
