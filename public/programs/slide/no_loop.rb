def setup
  createCanvas(400, 400) # 画面のサイズ
  colorMode(RGB)         # 色の指定をRGBモードにする
  background(0, 30, 70)  # 背景色を指定(RGBで)
  blendMode(OVERLAY)     # ブレンドモードを指定(OVERLAY)
end

def draw
  noLoop                        # draw()を1回だけ実行する
  1500.times do | i |           # 1500回繰り返す
    noStroke                  # 輪郭線を描かない
    fill(170, 200, 255)       # 塗りの色(RGBで)
    ellipse(random(0, 400), random(0, 400), 30)
  end
end
