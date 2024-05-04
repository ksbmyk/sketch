def setup
  createCanvas(400, 400)
  background("#fced4f")
  noLoop
end

def draw
  translate(width / 2, height / 2) # 原点をキャンパスの中心に
  rotate(PI/2)

  # 枠線
  strokeWeight(8)
  fill("#9cee60")
  ellipse(0, 0, 120*2 +40, 120*2 +40)
 
  fill(255)
  strokeWeight(2)
  ellipse(0, 0, 120*2 +10, 120*2 +10) # 模様の外側
  fill("#9cee60")
  ellipse(0, 0, 120*2 -50, 120*2 -50) # 模様の内側
  
  fill(0)
  noStroke
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
    if i.odd?
    	rect(0, 0, 10, 10) # 四角形を描画
    else
      rect(0, 0-10, 10, 10) # 四角形を描画
      rect(0, 0+10, 10, 10) # 四角形を描画
    end
    pop()
  end
  
  # 円周上の四角2
  rect_count = 10 #四角形の数
  radius = 110 # 円の半径
  interval_angle = TWO_PI / rect_count # 各四角形の間隔の角度

  rect_count.times do |i|
    angle = i * interval_angle # 四角形の角度
    x = radius * cos(angle) # x座標を計算
    y = radius * sin(angle) # y座標を計算
    push()
    translate(x, y) # 四角形の位置を移動
    rotate(angle) # 四角形を円周に沿って回転
    rectMode(CENTER)
    if i.even?
    	rect(0, 0, 10, 10)
    else
      rect(0, 0-10, 10, 10)
      rect(0, 0+10, 10, 10)
    end
    pop()
  end
  
  # 円周上の四角3
  rect_count = 10 #四角形の数
  radius = 120 # 円の半径
  interval_angle = TWO_PI / rect_count # 各四角形の間隔の角度

  rect_count.times do |i|
    angle = i * interval_angle # 四角形の角度
    x = radius * cos(angle) # x座標を計算
    y = radius * sin(angle) # y座標を計算
    push()
    translate(x, y) # 四角形の位置を移動
    rotate(angle) # 四角形を円周に沿って回転
    rectMode(CENTER)
    if i.odd?
    	rect(0, 0, 10, 10)
    else
      rect(0, 0-10, 10, 10)
      rect(0, 0+10, 10, 10)
    end
    pop()
  end
  
  # 枠線
  stroke(0)
  strokeWeight(2)
  fill(255)
  ellipse(0, 0, 120*2 -70, 120*2 -70)
  
end
