# ruby会議大阪03用
$base = 80
def setup
  createCanvas(600, 600)
  colorMode(RGB)
  angleMode(DEGREES)        #ラジアンではなく、360度で指定
  background(255, 255, 255)

end

def draw
  noLoop
  noStroke

  # arc(x, y, w, h, start, stop)
  # 赤丸
  fill('#ba083d')
  arc($base, $base , $base * 2, $base * 2, 0, 360)

  # グレー円弧
  fill('#a9a7ad')
  arc($base * 3, $base , $base * 2, $base * 2,  90,  180)
  arc($base * 4, $base , $base * 2, $base * 2,  180,  270)

  # グレー半円
  fill('#444444')
  arc($base * 5,  $base , $base * 2, $base * 2,  0,  180)
end