def setup
  createCanvas(600, 600)
  angleMode(DEGREES)
end

def draw
  background('#0a9b94')
  translate(300, 300)
  # 白でマル
  noStroke

  # 胴体
  fill(255)
  ellipse(0, 0, 100, 108)

  # 羽
  arc(-30, -20 , 110, 110,  90,  180)
  arc(30, -20 , 110, 110,  0,  90)

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
