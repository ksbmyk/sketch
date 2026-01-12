def setup
  createCanvas(700, 700)
  noLoop
  colorMode(HSB, 360, 100, 100, 100)
end

def draw
  background(220, 60, 15)
  
  translate(width / 2, height / 2)
  
  # === 髪（おかっぱ）===
  noStroke
  fill(220, 70, 20)

  beginShape
  # 左側の輪郭（上から下へ）
  vertex(-120, -80)   # 左上
  vertex(-130, 0)     # 左側頭部
  vertex(-130, 100)   # 左サイド下
  vertex(-120, 170)   # 左肩あたり
  # 下側
  vertex(-60, 170)    # 左下内側
  vertex(-60, 170)    # 首の左
  vertex(60, 170)     # 首の右
  vertex(60, 170)     # 右下内側
  vertex(120, 170)    # 右肩あたり
  # 右側の輪郭（下から上へ）
  vertex(130, 100)    # 右サイド下
  vertex(130, 0)      # 右側頭部
  vertex(120, -80)    # 右上
  
  # 頭頂部（曲線的に）
  vertex(80, -120)    # 右上カーブ
  vertex(0, -140)     # てっぺん
  vertex(-80, -120)   # 左上カーブ
  endShape(CLOSE)
  
  # === 首 ===
  fill(220, 30, 65)
  rectMode(CENTER)
  rect(0, 160, 60, 80, 5)
  
  # === 顔 ===
  fill(220, 30, 70)
  ellipse(0, 30, 200, 240)
  
  # 前髪（ぱっつん）
 fill(220, 70, 20)
  beginShape
  vertex(-110, -80)
  vertex(-100, -30)
  vertex(-60, -30)
  vertex(0, -30)
  vertex(60, -30)
  vertex(100, -30)
  vertex(110, -80)
  vertex(80, -110)
  vertex(0, -130)
  vertex(-80, -110)
  endShape(CLOSE)
  

  
  # === メガネ ===
  stroke(220, 50, 40)
  strokeWeight(6)
  noFill
  
  # レンズ（角丸矩形）
  rectMode(CENTER)
  rect(-45, 10, 70, 50, 10)
  rect(45, 10, 70, 50, 10)
  # ブリッジ
  line(-10, 10, 10, 10)
  # テンプル（つる）
  line(-80, 10, -100, 5)
  line(80, 10, 100, 5)
  
  # === 目 ===
  noStroke
  fill(220, 60, 30)
  ellipse(-45, 15, 20, 25)
  ellipse(45, 15, 20, 25)
  
  # 瞳のハイライト
  fill(220, 20, 90)
  ellipse(-42, 12, 6, 6)
  ellipse(48, 12, 6, 6)
  
  # === 鼻 ===
  fill(220, 35, 60)
  triangle(0, 30, -12, 70, 12, 70)
  
  # === 口 ===
  fill(220, 40, 50)
  ellipse(0, 100, 40, 15)

end