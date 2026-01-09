# GENUARY 2026 jan9 "Crazy automaton. Cellular automata with crazy rules."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @cell_size = 7
  @grid_size = 100
  @num_states = 6  # 状態数
  @threshold = 1   # 次の状態に進むのに必要な近傍数
  @reverse_zones = []  # 逆回転ゾーン
  
  # グリッド初期化（ランダム状態）
  @grid = []
  @grid_size.times do |y|
    row = []
    @grid_size.times do |x|
      row.push(rand(@num_states))
    end
    @grid.push(row)
  end
  
  # 各セルの回転方向（1=順方向、-1=逆方向）
  @direction = []
  @grid_size.times do
    row = []
    @grid_size.times { row.push(1) }
    @direction.push(row)
  end

  frameRate(12)
end

def draw
  background(230, 30, 8)
  
  apply_reverse_zones
  draw_cells
  draw_zones
  update_automaton
end

def mousePressed
  # クリック位置をグリッド座標に変換
  gx = (mouseX / @cell_size).to_i
  gy = (mouseY / @cell_size).to_i
  
  @reverse_zones.push({
    gx: gx, gy: gy,
    px: mouseX, py: mouseY,
    radius: 0, max_radius: 25, speed: 1.5
  })
end

# 逆回転ゾーンの拡大と適用
def apply_reverse_zones
  @reverse_zones.each do |z|
    old_radius = z[:radius]
    z[:radius] += z[:speed]
    new_radius = z[:radius]
    
    (-z[:max_radius]..z[:max_radius]).each do |dy|
      (-z[:max_radius]..z[:max_radius]).each do |dx|
        dist = Math.sqrt(dx * dx + dy * dy)
        next if dist > new_radius || dist < old_radius
        
        nx = (z[:gx] + dx) % @grid_size
        ny = (z[:gy] + dy) % @grid_size
        
        # 回転方向を反転
        @direction[ny][nx] = -@direction[ny][nx]
      end
    end
  end
  
  @reverse_zones.select! { |z| z[:radius] < z[:max_radius] }
end

def draw_zones
  noStroke
  
  @reverse_zones.each do |z|
    r = z[:radius]
    alpha = 90 * (1.0 - r / z[:max_radius])
    
    (-z[:max_radius]..z[:max_radius]).each do |dy|
      (-z[:max_radius]..z[:max_radius]).each do |dx|
        dist = Math.sqrt(dx * dx + dy * dy)
        next if dist > r + 1.5 || dist < r - 0.5
        
        nx = (z[:gx] + dx) % @grid_size
        ny = (z[:gy] + dy) % @grid_size
        
        px = nx * @cell_size
        py = ny * @cell_size
        center_x = px + @cell_size / 2
        center_y = py + @cell_size / 2
        
        fill(200, 60, 100, alpha * 0.5)
        ellipse(center_x, center_y, @cell_size * 2.5, @cell_size * 2.5)
      end
    end
  end
end

def update_automaton
  new_grid = []
  @grid_size.times do
    row = []
    @grid_size.times { row.push(0) }
    new_grid.push(row)
  end
  
  @grid_size.times do |y|
    @grid_size.times do |x|
      current = @grid[y][x].to_i
      dir = @direction[y][x]
      
      # 次の状態（回転方向に依存）
      next_state = (current + dir + @num_states) % @num_states

      # 同じ回転方向の近傍のみカウント
      count = count_same_direction_neighbors(x, y, next_state, dir)

      if count >= @threshold
        new_grid[y][x] = next_state
      else
        new_grid[y][x] = current
      end
    end
  end
  
  @grid = new_grid
end

# 同じ回転方向で、指定した状態を持つ近傍セルの数をカウント
def count_same_direction_neighbors(x, y, target_state, my_dir)
  count = 0
  (-1..1).each do |dy|
    (-1..1).each do |dx|
      next if dx == 0 && dy == 0
      nx = (x + dx) % @grid_size
      ny = (y + dy) % @grid_size

      # 同じ回転方向のセルのみカウント
      next if @direction[ny][nx] != my_dir

      count += 1 if @grid[ny][nx].to_i == target_state
    end
  end
  count
end

def draw_cells
  noStroke
  
  @grid_size.times do |y|
    @grid_size.times do |x|
      state = @grid[y][x].to_i
      dir = @direction[y][x]

      px = x * @cell_size
      py = y * @cell_size
      center_x = px + @cell_size / 2
      center_y = py + @cell_size / 2
      
      # 状態に応じた色相（シアン〜青の範囲: 180〜240）
      hue = 180 + (state * 10)

      # 逆回転セルは明度を変えて区別
      if dir == -1
        brightness = 100
        saturation = 80
      else
        brightness = 70
        saturation = 70
      end
      
      fill(hue, saturation, brightness, 25)
      ellipse(center_x, center_y, @cell_size * 2, @cell_size * 2)
      fill(hue, saturation, brightness, 90)
      rect(px, py, @cell_size - 1, @cell_size - 1)
    end
  end
end
