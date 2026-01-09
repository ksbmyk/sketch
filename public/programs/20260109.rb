def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @cell_size = 7
  @grid_size = 100
  @explosions = []
  
  # グリッド初期化（中央付近に配置）
  @grid = []
  @grid_size.times do |y|
    row = []
    @grid_size.times do |x|
      dist = Math.sqrt((x - 50)**2 + (y - 50)**2)
      if dist < 30
        row.push(rand < 0.4 ? 1 : 0)
      else
        row.push(0)
      end
    end
    @grid.push(row)
  end
  
  frameRate(12)
end

def draw
  background(230, 30, 8)
  
  apply_explosions
  draw_cells
  draw_explosions
  update_automaton
end

def mousePressed
  # クリック位置をグリッド座標に変換
  gx = (mouseX / @cell_size).to_i
  gy = (mouseY / @cell_size).to_i
  
  # 爆発追加
  @explosions.push({
    gx: gx,
    gy: gy,
    px: mouseX,
    py: mouseY,
    radius: 0,
    max_radius: 12,
    speed: 0.8
  })
end

# 爆発の広がりに合わせてセルを追加
def apply_explosions
  @explosions.each do |e|
    old_radius = e[:radius]
    e[:radius] += e[:speed]
    new_radius = e[:radius]
    
    # 今フレームで広がった範囲にセルを追加
    (-e[:max_radius]..e[:max_radius]).each do |dy|
      (-e[:max_radius]..e[:max_radius]).each do |dx|
        dist = Math.sqrt(dx * dx + dy * dy)
        
        # このフレームで波が通過した範囲
        next if dist > new_radius || dist < old_radius
        
        nx = (e[:gx] + dx) % @grid_size
        ny = (e[:gy] + dy) % @grid_size
        
        # 高確率でセル発生
        @grid[ny][nx] = 1 if rand < 0.7
      end
    end
  end
  
  @explosions.select! { |e| e[:radius] < e[:max_radius] }
end

def draw_explosions
  noStroke
  
  @explosions.each do |e|
    r = e[:radius]
    alpha = 90 * (1.0 - r / e[:max_radius])
    
    # リングをセル単位で描画
    (-e[:max_radius]..e[:max_radius]).each do |dy|
      (-e[:max_radius]..e[:max_radius]).each do |dx|
        dist = Math.sqrt(dx * dx + dy * dy)
        
        # リングの幅（内側と外側の境界）
        next if dist > r + 1.5 || dist < r - 0.5
        
        nx = (e[:gx] + dx) % @grid_size
        ny = (e[:gy] + dy) % @grid_size
        
        px = nx * @cell_size
        py = ny * @cell_size
        center_x = px + @cell_size / 2
        center_y = py + @cell_size / 2
        
        # グロー
        fill(190, 60, 100, alpha * 0.4)
        ellipse(center_x, center_y, @cell_size * 2.5, @cell_size * 2.5)
        
        # セル本体
        fill(190, 70, 100, alpha)
        rect(px, py, @cell_size - 1, @cell_size - 1)
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
      n = count_neighbors(x, y)
      current = @grid[y][x].to_i
      
      if current == 1
        new_grid[y][x] = (n == 2 || n == 3) ? 1 : 0
      else
        new_grid[y][x] = (n == 3) ? 1 : 0
      end
    end
  end
  
  @grid = new_grid
end

def count_neighbors(x, y)
  total = 0
  (-1..1).each do |dy|
    (-1..1).each do |dx|
      next if dx == 0 && dy == 0
      nx = (x + dx) % @grid_size
      ny = (y + dy) % @grid_size
      total += @grid[ny][nx].to_i
    end
  end
  total
end

def draw_cells
  noStroke
  
  @grid_size.times do |y|
    @grid_size.times do |x|
      next if @grid[y][x].to_i == 0
      
      px = x * @cell_size
      py = y * @cell_size
      center_x = px + @cell_size / 2
      center_y = py + @cell_size / 2
      
      hue = 180 + (x + y) % 40
      
      fill(hue, 70, 85, 25)
      ellipse(center_x, center_y, @cell_size * 2, @cell_size * 2)
      fill(hue, 70, 85, 90)
      rect(px, py, @cell_size - 1, @cell_size - 1)
    end
  end
end
