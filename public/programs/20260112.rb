def setup
  createCanvas(700, 700, WEBGL)
  colorMode(HSB, 360, 100, 100, 100)
  noStroke
end

def draw
  background(230, 80, 15)
  
  # カメラ設定
  rotateX(-0.6)
  rotateY(frameCount * 0.005)
  
  # ライティング
  ambientLight(60)
  directionalLight(200, 30, 100, 0.5, 1, -0.5)
  
  box_size = 40
  grid_count = 9
  offset = (grid_count - 1) * box_size / 2.0
  
  grid_count.times do |i|
    grid_count.times do |j|
      x = i * box_size - offset
      z = j * box_size - offset
      
      # 波状の高さ計算
      # 中心からの距離と時間で波を作る
      dist = Math.sqrt((i - grid_count / 2.0) ** 2 + (j - grid_count / 2.0) ** 2)
      wave = Math.sin(dist * 0.8 - frameCount * 0.05)
      height = map(wave, -1, 1, 1, 5).to_i
      
      # 色相を位置と高さで変化
      hue = map(dist, 0, grid_count / 2.0, 190, 240)
      
      height.times do |k|
        y = -k * box_size - box_size / 2.0
        
        push
        translate(x, y, z)
        
        # 高さに応じて明度を変化
        brightness = map(k, 0, 4, 50, 90)
        fill(hue, 70, brightness)
        
        box(box_size * 0.9)
        pop
      end
    end
  end
end
