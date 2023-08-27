def setup
  createCanvas(400, 400) # 画面のサイズ
  background('#001e46')  # 背景色を指定
  blendMode(OVERLAY)     # ブレンドモードを指定(OVERLAY)
end

def draw
    noStroke                  # 輪郭線を描かない
    fill('#aac8ff')
    # 円を描く。位置は0-900の間でランダムに決める。大きさは30
    ellipse(random(0, 400), random(0, 400), 30)
end
