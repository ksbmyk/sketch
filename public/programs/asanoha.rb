# 麻の葉ベース  https://zenn.dev/vava/articles/cfe736a5c4fcd0#%E9%BA%BB%E3%81%AE%E8%91%89
def setup
  r = 60
  rr = nil
  rx = nil

  size(windowWidth, windowHeight)
  angleMode(DEGREES)
  no_fill
  background("#c0a2c7")
  stroke(255)

  rr = r / 2 / cos(30)
  rx = sin(60) * r * 2
end

def draw
  for j in (0..height).step(r)
    for i in (0..width + rx).step(rx)
      drawPoly(i, j)
    end
  end
end

def drawPoly(x, y)
  center = [0, 0]
  outline = []
  inline = []

  pushMatrix
  translate(x, y)

  for i in (0..5)
    outline[i] = [r * sin((360 * i) / 6), r * cos((360 * i) / 6)]
    inline[i] = [rr * sin((360 * i) / 6 + 30), rr * cos((360 * i) / 6 + 30)]
  end

  beginShape
  for i in (0..5)
    vertex(outline[i][0], outline[i][1])
  end
  endShape(CLOSE)

  for i in (0..5)
    line(center[0], center[1], outline[i][0], outline[i][1])
    line(inline[i][0], inline[i][1], 0, 0)
    line(inline[i][0], inline[i][1], outline[i][0], outline[i][1])

    ii = i + 1
    ii = 0 if i == 5
    line(inline[i][0], inline[i][1], outline[ii][0], outline[ii][1])
  end

  popMatrix
end
