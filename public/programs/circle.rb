def setup
  createCanvas(500, 500)
  colorMode(RGB)
  angleMode(DEGREES)        #ラジアンではなく、360度で指定
  background(255, 255, 255)

end

def draw
  noLoop
  noStroke

  # ellipse(x, y, w, h)
  # 赤丸
  fill('#ba083d')
  ellipse(50, 50, 100, 100)

  # arc(x, y, w, h, start, stop)
  # グレー円弧
  fill('#a9a7ad')
  arc(150, 50 , 100, 100,  90,  180)
  arc(200, 50 , 100, 100,  180,  270)

  # グレー半円
  fill('#444444')
  arc(250, 50 , 100, 100,  0,  180)
end
