# GENUARY 2024 jan19 "Flocking."
# https://genuary.art/prompts


def setup
  createCanvas(720, 720)
  @flock = []
  80.times do
    # ランダムな座標の範囲を円にする
    angle = random(0, TWO_PI) # 円周上のランダムな角度
    distance = random(0, 100) # 原点から許容する距離
    x = distance * cos(angle)
    y = distance * sin(angle)
    @flock << createVector(x, y)
  end

end

def draw
  background(0)
  translate(width / 2, height / 2)
  
  @flock.each do |flock|
    fill(127, 127)
    stroke(200)
    rect(flock.x, flock.y, 30, 30)

    # ランダムな方向に動かす
    angle = random(0, TWO_PI)
    speed = 0.15 # 移動速度
    
    delta_x = cos(angle) * speed
    delta_y = sin(angle) * speed
    
    # 座標の更新
    flock.x += delta_x
    flock.y += delta_y
  end
end
