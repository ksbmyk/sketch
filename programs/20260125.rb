# GENUARY 2026 jan25 "Organic Geometry. Forms that look or act organic but are constructed entirely from geometric shapes."
# https://genuary.art/prompts


WIDTH = 700
HEIGHT = 700
NUM_CELLS = 60
CELL_MARGIN = 4

def setup
  createCanvas(WIDTH, HEIGHT)
  colorMode(HSB, 360, 100, 100, 100)
  
  @cells = []
  NUM_CELLS.times do |i|
    @cells << create_cell(
      rand(50..(WIDTH - 50)),
      rand(50..(HEIGHT - 50)),
      rand(30..50),
      i
    )
  end
end

def create_cell(x, y, r, index)
  {
    x: x,
    y: y,
    r: r,
    vx: 0,
    vy: 0,
    noise_offset: index * 1000,
    hue: rand(180..220)
  }
end

def draw
  background(0, 0, 100)
  
  update_cells
  resolve_collisions
  
  @cells.each { |cell| draw_cell(cell) }
end

def update_cells
  t = frameCount * 0.005
  
  @cells.each do |cell|
    # Perlinノイズによる方向決定
    angle = noise(cell[:noise_offset] + t) * TWO_PI * 2
    force = 0.05
    
    cell[:vx] += cos(angle) * force
    cell[:vy] += sin(angle) * force
    
    # 摩擦
    cell[:vx] *= 0.95
    cell[:vy] *= 0.95
    
    # 位置更新
    cell[:x] += cell[:vx]
    cell[:y] += cell[:vy]
    
    # 画面端での反発
    margin = cell[:r] + CELL_MARGIN
    if cell[:x] < margin
      cell[:x] = margin
      cell[:vx] *= -0.5
    elsif cell[:x] > WIDTH - margin
      cell[:x] = WIDTH - margin
      cell[:vx] *= -0.5
    end
    
    if cell[:y] < margin
      cell[:y] = margin
      cell[:vy] *= -0.5
    elsif cell[:y] > HEIGHT - margin
      cell[:y] = HEIGHT - margin
      cell[:vy] *= -0.5
    end
  end
end

def resolve_collisions
  @cells.each_with_index do |a, i|
    @cells[(i + 1)..].each do |b|
      dx = b[:x] - a[:x]
      dy = b[:y] - a[:y]
      dist = Math.sqrt(dx * dx + dy * dy)
      min_dist = a[:r] + b[:r] + CELL_MARGIN
      
      if dist < min_dist
        if dist < 0.001
          angle = rand * TWO_PI
          nx = Math.cos(angle)
          ny = Math.sin(angle)
          dist = 0.001
        else
          nx = dx / dist
          ny = dy / dist
        end
        
        overlap = (min_dist - dist) / 2.0
        
        a[:x] -= nx * overlap
        a[:y] -= ny * overlap
        b[:x] += nx * overlap
        b[:y] += ny * overlap
        
        force = overlap * 0.1
        a[:vx] -= nx * force
        a[:vy] -= ny * force
        b[:vx] += nx * force
        b[:vy] += ny * force
      end
    end
  end
end

def draw_cell(cell)
  x, y, r, hue = cell[:x], cell[:y], cell[:r], cell[:hue]
  
  noFill
  stroke(hue, 60, 100, 80)
  strokeWeight(2)
  ellipse(x, y, r * 2, r * 2)
  
  fill(hue, 100, 90, 40)
  noStroke
  ellipse(x, y, r * 1.8, r * 1.8)
end