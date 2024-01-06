# GENUARY 2024 jan7 Progress bar / indicator / loading animation.
# https://genuary.art/prompts

def setup
  createCanvas(600, 600)
  angleMode(DEGREES) #０°〜３６０°で扱う
  @num_circles = 10 # 円の数
  @angle = 0 # 角度
  @max_alpha = 0 # 最大の透明度
end

def draw
  background("#2EAADC")
  translate(width / 2, height / 2) #  画面の中心に移動

  @angle += 2 #  回転角度を更新
  rotate(@angle) # 指定された角度だけ回転

  radius = 80 # 円の半径

  (1..@num_circles).each do |i|
    x = cos(360 / @num_circles * i) * radius;
    y = sin(360 / @num_circles * i) * radius;

    alpha = map(sin(@angle + i * 20), -1, 1, 255, 0)# 透明度の計算
    @max_alpha = max(@max_alpha, alpha)# 最大の透明度を更新

    noStroke
    fill(255, 255, 255, alpha) # 白色の円を透明度を変えながら描画
    ellipse(x, y, 20, 20) # 円を描画
  end  
end
