BOX_SIZE = 40
GRID_COUNT = 9

def setup
  createCanvas(700, 700, WEBGL)
  colorMode(HSB, 360, 100, 100, 100)
end

def draw
  background(230, 80, 15)
  
  # カメラ設定
  rotateX(-0.6)
  rotateY(frameCount * 0.005)
  
  # ライティング
  ambientLight(100)
  directionalLight(200, 30, 100, 0.5, 1, -0.5)
  
  offset = (GRID_COUNT - 1) * BOX_SIZE / 2.0

  # グローレイヤー
  noStroke
  GRID_COUNT.times do |i|
    GRID_COUNT.times do |j|
      x = i * BOX_SIZE - offset
      z = j * BOX_SIZE - offset
      
      dist = Math.sqrt((i - GRID_COUNT / 2.0) ** 2 + (j - GRID_COUNT / 2.0) ** 2)
      wave = Math.sin(dist * 0.8 - frameCount * 0.05)
      height = map(wave, -1, 1, 1, 5).to_i
      hue = map(dist, 0, GRID_COUNT / 2.0, 190, 240)
      
      height.times do |k|
        y = -k * BOX_SIZE - BOX_SIZE / 2.0

        # グロー
        3.times do |g|
          push
          translate(x, y, z)
          glow_size = BOX_SIZE * (1.1 + g * 0.15)
          glow_alpha = 8 - g * 2
          fill(hue, 60, 100, glow_alpha)
          box(glow_size)
          pop
        end
      end
    end
  end

  # 本体の立方体
  GRID_COUNT.times do |i|
    GRID_COUNT.times do |j|
      x = i * BOX_SIZE - offset
      z = j * BOX_SIZE - offset

      dist = Math.sqrt((i - GRID_COUNT / 2.0) ** 2 + (j - GRID_COUNT / 2.0) ** 2)
      wave = Math.sin(dist * 0.8 - frameCount * 0.05)
      height = map(wave, -1, 1, 1, 5).to_i
      hue = map(dist, 0, GRID_COUNT / 2.0, 190, 240)

      height.times do |k|
        y = -k * BOX_SIZE - BOX_SIZE / 2.0

        push
        translate(x, y, z)
        brightness = map(k, 0, 4, 70, 100)
        fill(hue, 70, brightness)
        box(BOX_SIZE * 0.9)
        pop
      end
    end
  end
end
