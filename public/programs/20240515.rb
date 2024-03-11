def setup
  createCanvas(400, 400)
  background(220)
  noLoop
end

def draw
  translate(width / 2, height / 2) # 原点をキャンパスの中心に
 
  # 円周上の四角
  rect_count = 10 #四角形の数
  radius = 100 # 円の半径
  interval_angle = TWO_PI / rect_count # 各四角形の間隔の角度

  rect_count.times do |i|
    angle = i * interval_angle # 四角形の角度
    x = radius * cos(angle) # x座標を計算
    y = radius * sin(angle) # y座標を計算
    push()
    translate(x, y) # 四角形の位置を移動
    rotate(angle) # 四角形を円周に沿って回転
    rectMode(CENTER)
    rect(0, 0, 10, 10) # 四角形を描画
    pop()
  end
  noFill()
  ellipse(0, 0, radius*2 -10, radius*2 -10)
  ellipse(0, 0, radius*2 +10, radius*2 +10)
end
