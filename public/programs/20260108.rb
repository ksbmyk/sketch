PHASE_MAIN_ROADS = 0      # 幹線道路を描く
PHASE_SUBDIVIDE = 1       # ブロック細分化
PHASE_BUILDINGS = 2       # 建物立ち上がり
PHASE_COMPLETE = 3        # 完成

$phase = PHASE_MAIN_ROADS
$phase_progress = 0.0
$blocks = []
$buildings = []
$main_roads = []

# 道路の幅
MAIN_ROAD_WIDTH = 8
SUB_ROAD_WIDTH = 2

# 色定義（HSB: 色相, 彩度, 明度）
COLOR_ROAD_GLOW = [190, 255, 200]      # シアン系
COLOR_BUILDING_BASE = [250, 200, 80]   # 暗い紫
COLOR_BUILDING_GLOW = [200, 255, 255]  # 明るいシアン

class Block
  attr_accessor :x, :y, :w, :h, :children, :depth, :subdivided, :draw_progress

  def initialize(x, y, w, h, depth = 0)
    @x = x
    @y = y
    @w = w
    @h = h
    @depth = depth
    @children = []
    @subdivided = false
    @draw_progress = 0.0
  end

  # ブロックを分割
  def subdivide
    return if @subdivided
    return if @w < 35 || @h < 35  # 最小サイズ
    
    @subdivided = true
    
    # 分割方向を決定（長い方を分割しやすく）
    horizontal = @w > @h ? rand < 0.3 : rand < 0.7
    
    if horizontal && @h > 50
      # 水平分割
      split = @y + @h * rand(0.3..0.7)
      @children << Block.new(@x, @y, @w, split - @y, @depth + 1)
      @children << Block.new(@x, split + SUB_ROAD_WIDTH, @w, @y + @h - split - SUB_ROAD_WIDTH, @depth + 1)
    elsif @w > 50
      # 垂直分割
      split = @x + @w * rand(0.3..0.7)
      @children << Block.new(@x, @y, split - @x, @h, @depth + 1)
      @children << Block.new(split + SUB_ROAD_WIDTH, @y, @x + @w - split - SUB_ROAD_WIDTH, @h, @depth + 1)
    end
    
    # 子ブロックも確率的に分割
    @children.each do |child|
      child.subdivide if rand < 0.9 - child.depth * 0.1
    end
  end

  # 末端ブロック（建物が建つ場所）を取得
  def leaf_blocks
    if @children.empty?
      [self]
    else
      @children.flat_map(&:leaf_blocks)
    end
  end
end

class Building
  attr_accessor :x, :y, :w, :h, :floors, :grow_progress

  def initialize(x, y, w, h)
    @x = x
    @y = y
    @w = w
    @h = h
    # 高さ（階数）- 面積と乱数で決定、階数を増やす
    area_factor = Math.sqrt(@w * @h) / 35.0
    @floors = (rand(3..8) * area_factor).clamp(3, 15).to_i
    @grow_progress = 0.0
  end

  def fully_grown?
    @grow_progress >= 1.0
  end
end

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 255, 255, 255)
  
  init_city
end

def init_city
  $phase = PHASE_MAIN_ROADS
  $phase_progress = 0.0
  $blocks = []
  $buildings = []
  $main_roads = []
  
  # キャンバスのマージン
  margin = 20
  
  # 幹線道路の配置（3-4本の縦横道路）
  num_v = rand(3..4)
  v_positions = (1..num_v).map { margin + rand(80..(700 - margin * 2 - 80)) }.sort
  
  num_h = rand(3..4)
  h_positions = (1..num_h).map { margin + rand(80..(700 - margin * 2 - 80)) }.sort
  
  # 道路データを保存
  v_positions.each do |x|
    $main_roads << { x1: x, y1: margin, x2: x, y2: 700 - margin, horizontal: false }
  end
  h_positions.each do |y|
    $main_roads << { x1: margin, y1: y, x2: 700 - margin, y2: y, horizontal: true }
  end
  
  # 幹線道路で区切られたブロックを生成
  x_edges = [margin] + v_positions.map { |x| [x - MAIN_ROAD_WIDTH/2, x + MAIN_ROAD_WIDTH/2] }.flatten + [700 - margin]
  y_edges = [margin] + h_positions.map { |y| [y - MAIN_ROAD_WIDTH/2, y + MAIN_ROAD_WIDTH/2] }.flatten + [700 - margin]
  
  # ブロックを生成（道路部分を除く）
  (0...(x_edges.length - 1)).step(2) do |i|
    (0...(y_edges.length - 1)).step(2) do |j|
      x = x_edges[i]
      y = y_edges[j]
      w = x_edges[i + 1] - x
      h = y_edges[j + 1] - y
      
      if w > 30 && h > 30
        block = Block.new(x, y, w, h)
        $blocks << block
      end
    end
  end
end

def draw
  background(240, 40, 15)  # 暗い青紫の背景
  
  case $phase
  when PHASE_MAIN_ROADS
    draw_phase_main_roads
  when PHASE_SUBDIVIDE
    draw_phase_subdivide
  when PHASE_BUILDINGS
    draw_phase_buildings
  when PHASE_COMPLETE
    draw_phase_complete
  end
end

# 幹線道路
def draw_phase_main_roads
  $phase_progress += 0.006
  
  blendMode(ADD)
  
  $main_roads.each_with_index do |road, i|
    delay = i * 0.15
    progress = (($phase_progress - delay) * 1.5).clamp(0, 1)
    next if progress <= 0
    
    eased_progress = ease_out_cubic(progress)
    
    if road[:horizontal]
      draw_len = (road[:x2] - road[:x1]) * eased_progress
      draw_road_segment(road[:x1], road[:y1], road[:x1] + draw_len, road[:y1])
    else
      draw_len = (road[:y2] - road[:y1]) * eased_progress
      draw_road_segment(road[:x1], road[:y1], road[:x1], road[:y1] + draw_len)
    end
  end
  
  blendMode(BLEND)
  
  # 次へ
  last_road_delay = ($main_roads.length - 1) * 0.15
  if $phase_progress >= last_road_delay + 0.8
    $phase = PHASE_SUBDIVIDE
    $phase_progress = 0.0
    $blocks.each(&:subdivide)
  end
end

# イージング関数
def ease_out_cubic(t)
  1 - (1 - t) ** 3
end

def ease_in_out_quad(t)
  t < 0.5 ? 2 * t * t : 1 - (-2 * t + 2) ** 2 / 2
end

# 道路セグメントを発光させて描画
def draw_road_segment(x1, y1, x2, y2)
  width = MAIN_ROAD_WIDTH
  
  # グロー効果
  [16, 10, 5, 2].each_with_index do |w, i|
    alpha = [25, 50, 100, 220][i]
    stroke(COLOR_ROAD_GLOW[0], COLOR_ROAD_GLOW[1], COLOR_ROAD_GLOW[2], alpha)
    strokeWeight(width + w)
    line(x1, y1, x2, y2)
  end
end

# ブロック細分化
def draw_phase_subdivide
  $phase_progress += 0.005
  
  # 幹線道路
  blendMode(ADD)
  $main_roads.each do |road|
    draw_road_segment(road[:x1], road[:y1], road[:x2], road[:y2])
  end
  blendMode(BLEND)
  
  # ブロックの境界
  all_blocks = $blocks.flat_map(&:leaf_blocks)
  
  noFill
  all_blocks.each_with_index do |block, i|
    delay = i * 0.008
    progress = (($phase_progress - delay) * 1.5).clamp(0, 1)
    block.draw_progress = ease_out_cubic(progress)
    next if block.draw_progress <= 0
    
    alpha = (block.draw_progress * 180).to_i
    
    blendMode(ADD)
    stroke(COLOR_ROAD_GLOW[0], COLOR_ROAD_GLOW[1], COLOR_ROAD_GLOW[2], alpha * 0.25)
    strokeWeight(SUB_ROAD_WIDTH + 3)
    rect(block.x, block.y, block.w * block.draw_progress, block.h * block.draw_progress)
    
    stroke(COLOR_ROAD_GLOW[0], COLOR_ROAD_GLOW[1], COLOR_ROAD_GLOW[2], alpha)
    strokeWeight(SUB_ROAD_WIDTH)
    rect(block.x, block.y, block.w * block.draw_progress, block.h * block.draw_progress)
    blendMode(BLEND)
  end
  
  # 次のフェーズへ
  last_block_delay = (all_blocks.length - 1) * 0.008
  if $phase_progress >= last_block_delay + 0.8
    $phase = PHASE_BUILDINGS
    $phase_progress = 0.0
    generate_buildings
  end
end

# 建物を生成
def generate_buildings
  all_blocks = $blocks.flat_map(&:leaf_blocks)
  
  all_blocks.each do |block|
    margin = SUB_ROAD_WIDTH + 1
    bx = block.x + margin
    by = block.y + margin
    bw = block.w - margin * 2
    bh = block.h - margin * 2
    
    next if bw < 10 || bh < 10
    
    $buildings << Building.new(bx, by, bw, bh)
  end
  
  # 建物を位置でソート
  $buildings.sort_by! { |b| b.x + b.y }
end

# 建物立ち上がり
def draw_phase_buildings
  $phase_progress += 0.004
  
  draw_all_roads
  
  $buildings.each_with_index do |building, i|
    delay = i * 0.006
    progress = (($phase_progress - delay) * 1.2).clamp(0, 1)
    building.grow_progress = ease_in_out_quad(progress)
    draw_building(building)
  end
  
  # 次へ
  last_building_delay = ($buildings.length - 1) * 0.006
  if $phase_progress >= last_building_delay + 1.0
    $phase = PHASE_COMPLETE
  end
end

# 完成（静止）
def draw_phase_complete
  draw_all_roads
  
  $buildings.each do |building|
    draw_building(building)
  end
end

# 全ての道路を描画
def draw_all_roads
  blendMode(ADD)
  $main_roads.each do |road|
    draw_road_segment(road[:x1], road[:y1], road[:x2], road[:y2])
  end
  blendMode(BLEND)
  
  # ブロック境界の細い道路
  all_blocks = $blocks.flat_map(&:leaf_blocks)
  noFill
  all_blocks.each do |block|
    blendMode(ADD)
    stroke(COLOR_ROAD_GLOW[0], COLOR_ROAD_GLOW[1], COLOR_ROAD_GLOW[2], 45)
    strokeWeight(SUB_ROAD_WIDTH + 3)
    rect(block.x, block.y, block.w, block.h)
    
    stroke(COLOR_ROAD_GLOW[0], COLOR_ROAD_GLOW[1], COLOR_ROAD_GLOW[2], 180)
    strokeWeight(SUB_ROAD_WIDTH)
    rect(block.x, block.y, block.w, block.h)
    blendMode(BLEND)
  end
end

# 建物を描画（輪郭の多重化で高さ表現）
def draw_building(building)
  return if building.grow_progress <= 0
  
  current_floors = (building.floors * building.grow_progress).to_i
  return if current_floors < 1
  
  # 各階層を描画
  current_floors.times do |floor|
    offset = floor * 2.5
    
    bx = building.x + offset
    by = building.y + offset
    bw = building.w - offset * 2
    bh = building.h - offset * 2
    
    next if bw < 4 || bh < 4
    
    # 階層の明るさ
    brightness_factor = 0.3 + (floor.to_f / building.floors) * 0.7
    alpha = (brightness_factor * 255 * building.grow_progress).to_i
    
    # 建物の塗り
    blendMode(ADD)
    fill(COLOR_BUILDING_BASE[0], COLOR_BUILDING_BASE[1], 
         (COLOR_BUILDING_BASE[2] * brightness_factor).to_i, alpha * 0.4)
    noStroke
    rect(bx, by, bw, bh)
    
    # 輪郭のグロー
    noFill
    stroke(COLOR_BUILDING_GLOW[0], COLOR_BUILDING_GLOW[1], 
           (COLOR_BUILDING_GLOW[2] * brightness_factor).to_i, alpha * 0.6)
    strokeWeight(1)
    rect(bx, by, bw, bh)
    blendMode(BLEND)
  end
end

def mousePressed
  init_city
end
