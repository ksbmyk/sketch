def setup
  createCanvas(500, 500)
  colorMode(RGB)
  angleMode(DEGREES)  #ラジアンではなく、360度で指定
  background(255, 255, 255)

end

def draw
  noLoop  # draw()を1回だけ実行する
  noStroke  # 輪郭線を描かない

  fill('#ba083d') # 円の赤
  ellipse(50, 50, 100, 100) # ellipse(x, y, w, h)

  fill('#a9a7ad') # 円弧のグレー
  arc(150, 50 , 100, 100,  90,  180)   # arc(x, y, w, h, start, stop)
  arc(200, 50 , 100, 100,  180,  270)

  fill('#444444') # 半円の濃いグレー
  arc(250, 50 , 100, 100,  0,  180)
end
