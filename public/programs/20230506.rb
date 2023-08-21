def setup
  createCanvas(800, 800) # 画面のサイズ
  colorMode(RGB)         # 色の指定をRGBモードにする
  background(0, 30, 70)  # 背景色を指定(RGBで)
  blendMode(OVERLAY)     # ブレンドモードを指定(OVERLAY)
end

def draw
  noLoop                        # draw()を1回だけ実行する
  1500.times do | i |           # 1500回繰り返す
    if i.even?                  # iが偶数の時
      noStroke                  # 輪郭線を描かない
      fill(170, 200, 255)       # 塗りの色(RGBで)
    else 
      stroke(170, 200, 255)     # 輪郭線の色を指定
      fill(255, 255, 255, 100)  # 塗りの色(RGBAで)
    end
    # 円を描く。位置は0-900の間でランダムに決める。大きさは30
    ellipse(random(0, 900), random(0, 900), 30)
  end
end
