# GENUARY 2026 jan19 "16x16"
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  noStroke
  colorMode(HSB, 360, 100, 100)
  @cell_size = 700.0 / 16
  @grid = Hash.new { |h, k| h[k] = {} }
  @time = 0
  frameRate(8)
end

def draw
  generate_kaleidoscope_pattern
  draw_grid
  
  @time += 1
end

def generate_kaleidoscope_pattern
  # 各ピクセルの角度を0～45°の範囲に折りたたむことで、8方向の対称性を生成
  center = 7.5 # 16×16グリッドのインデックスは0〜15なので中心は7.5
  
  16.times do |y|
    16.times do |x|
      # 中心座標に変換
      dx = x - center
      dy = y - center
      
      # 極座標に変換
      angle = atan2(dy, dx)
      dist = sqrt(dx * dx + dy * dy)
      
      # 角度を0からPI/4（45度）の範囲に折りたたむ
      # これによって8方向の対称性を作る
      angle = angle.abs
      angle = PI - angle if angle > PI / 2
      angle = PI / 2 - angle if angle > PI / 4
      
      # 折りたたまれた座標に基づいて値を生成
      # 時間を使ってアニメーションさせる
      phase = @time * 0.1
      
      # 折りたたまれた極座標を使ってパターンを作成
      pattern_val = sin(dist * 0.8 + phase) + 
                    cos(angle * 8 + phase * 0.5)
      
      # セカンダリパターンを追加
      pattern_val += sin(dist * 0.4 - phase * 0.7) * 0.5
      
      # 0から1の範囲に正規化
      val = (pattern_val + 2.5) / 5.0
      
      # 5段階にわける
      val = if val < 0.2
              0.0
            elsif val < 0.4
              0.25
            elsif val < 0.6
              0.5
            elsif val < 0.8
              0.75
            else
              1.0
            end
      
      @grid[y][x] = val
    end
  end
end

def draw_grid
  16.times do |y|
    16.times do |x|
      val = @grid[y][x]
      
      # 値を5つの青系の色にマッピング
      hue = 240 - val * 50
      sat = 85
      bri = 100
      
      fill(hue, sat, bri)
      rect(x * @cell_size, y * @cell_size, @cell_size, @cell_size)
    end
  end
end

