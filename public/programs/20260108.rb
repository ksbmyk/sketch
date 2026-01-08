CANVAS_SIZE = 700
MARGIN = 20

# フェーズ
PHASE_MAIN_ROADS = 0
PHASE_SUBDIVIDE = 1
PHASE_BUILDINGS = 2
PHASE_COMPLETE = 3

# 速度
SPEED_MAIN_ROADS = 0.006
SPEED_SUBDIVIDE = 0.005
SPEED_BUILDINGS = 0.004

# ブロック
BLOCK_MIN_SIZE = 35
BLOCK_MIN_SPLIT_SIZE = 50
BLOCK_SUBDIVIDE_PROBABILITY = 0.9
BLOCK_DEPTH_PENALTY = 0.1

# 道路
ROAD_MAIN_WIDTH = 8
ROAD_SUB_WIDTH = 2
ROAD_MAIN_COUNT = (3..4)
ROAD_COLOR_GLOW = [190, 255, 200]

# 建物
BUILDING_MIN_SIZE = 10
BUILDING_FLOOR_OFFSET = 1.5
BUILDING_FLOOR_RANGE = (2..5)
BUILDING_MAX_FLOORS = 10
BUILDING_COLOR_BASE = [250, 200, 80]
BUILDING_COLOR_GLOW = [200, 255, 255]

def ease_out_cubic(t)
  1 - (1 - t) ** 3
end

def ease_in_out_quad(t)
  t < 0.5 ? 2 * t * t : 1 - (-2 * t + 2) ** 2 / 2
end

class Block
  attr_reader :x, :y, :w, :h, :depth
  attr_accessor :draw_progress

  def initialize(x:, y:, w:, h:, depth: 0)
    @x, @y, @w, @h = x, y, w, h
    @depth = depth
    @children = []
    @draw_progress = 0.0
  end

  def subdivide
    return if subdivided?
    return if too_small?
    
    @subdivided = true
    create_children
    @children.each { |child| child.subdivide if should_subdivide?(child) }
  end

  def leaf_blocks
    @children.empty? ? [self] : @children.flat_map(&:leaf_blocks)
  end

  def subdivided?
    @subdivided
  end

  private

  def too_small?
    w < BLOCK_MIN_SIZE || h < BLOCK_MIN_SIZE
  end

  def should_subdivide?(child)
    rand < BLOCK_SUBDIVIDE_PROBABILITY - child.depth * BLOCK_DEPTH_PENALTY
  end

  def create_children
    horizontal = prefer_horizontal?
    
    if horizontal && h > BLOCK_MIN_SPLIT_SIZE
      split_horizontal
    elsif w > BLOCK_MIN_SPLIT_SIZE
      split_vertical
    end
  end

  def prefer_horizontal?
    w > h ? rand < 0.3 : rand < 0.7
  end

  def split_horizontal
    split_y = y + h * rand(0.3..0.7)

    @children << Block.new(x: x, y: y, w: w, h: split_y - y, depth: depth + 1)
    @children << Block.new(x: x, y: split_y + ROAD_SUB_WIDTH, w: w, h: y + h - split_y - ROAD_SUB_WIDTH, depth: depth + 1)
  end

  def split_vertical
    split_x = x + w * rand(0.3..0.7)
    
    @children << Block.new(x: x, y: y, w: split_x - x, h: h, depth: depth + 1)
    @children << Block.new(x: split_x + ROAD_SUB_WIDTH, y: y, w: x + w - split_x - ROAD_SUB_WIDTH, h: h, depth: depth + 1)
  end
end

class Building
  attr_reader :x, :y, :w, :h, :floors
  attr_accessor :grow_progress

  def initialize(x:, y:, w:, h:)
    @x, @y, @w, @h = x, y, w, h
    @floors = calculate_floors
    @grow_progress = 0.0
  end

  def fully_grown?
    grow_progress >= 1.0
  end

  def current_floors
    (floors * grow_progress).to_i
  end

  def sort_key
    x + y
  end

  private

  def calculate_floors
    area_factor = Math.sqrt(w * h) / 40.0
    (rand(BUILDING_FLOOR_RANGE) * area_factor).clamp(BUILDING_FLOOR_RANGE.begin, BUILDING_MAX_FLOORS).to_i
  end
end

class Road
  attr_reader :x1, :y1, :x2, :y2

  def initialize(x1:, y1:, x2:, y2:)
    @x1, @y1, @x2, @y2 = x1, y1, x2, y2
  end

  def horizontal?
    y1 == y2
  end

  def length
    horizontal? ? (x2 - x1) : (y2 - y1)
  end

  def draw_partial(progress)
    len = length * progress
    horizontal? ? [x1, y1, x1 + len, y1] : [x1, y1, x1, y1 + len]
  end
end

class City
  attr_reader :phase, :blocks, :buildings, :main_roads
  attr_accessor :phase_progress

  def initialize
    @phase = PHASE_MAIN_ROADS
    @phase_progress = 0.0
    @blocks = []
    @buildings = []
    @main_roads = []
    
    generate_main_roads
    generate_initial_blocks
  end

  def advance_phase
    case @phase
    when PHASE_MAIN_ROADS
      @phase = PHASE_SUBDIVIDE
      @phase_progress = 0.0
      blocks.each(&:subdivide)
    when PHASE_SUBDIVIDE
      @phase = PHASE_BUILDINGS
      @phase_progress = 0.0
      generate_buildings
    when PHASE_BUILDINGS
      @phase = PHASE_COMPLETE
    end
  end

  def all_leaf_blocks
    blocks.flat_map(&:leaf_blocks)
  end

  private

  def generate_main_roads
    road_range = (MARGIN + 80)..(CANVAS_SIZE - MARGIN - 80)
    
    v_positions = Array.new(rand(ROAD_MAIN_COUNT)) { rand(road_range) }.sort
    h_positions = Array.new(rand(ROAD_MAIN_COUNT)) { rand(road_range) }.sort
    
    v_positions.each { |x| @main_roads << Road.new(x1: x, y1: MARGIN, x2: x, y2: CANVAS_SIZE - MARGIN) }
    h_positions.each { |y| @main_roads << Road.new(x1: MARGIN, y1: y, x2: CANVAS_SIZE - MARGIN, y2: y) }
  end

  def generate_initial_blocks
    half_road = ROAD_MAIN_WIDTH / 2
    
    v_positions = main_roads.reject(&:horizontal?).map(&:x1)
    h_positions = main_roads.select(&:horizontal?).map(&:y1)
    
    x_edges = [MARGIN]
    v_positions.each do |x|
      x_edges << (x - half_road)
      x_edges << (x + half_road)
    end
    x_edges << (CANVAS_SIZE - MARGIN)
    
    y_edges = [MARGIN]
    h_positions.each do |y|
      y_edges << (y - half_road)
      y_edges << (y + half_road)
    end
    y_edges << (CANVAS_SIZE - MARGIN)
    
    (0...x_edges.length - 1).step(2) do |i|
      (0...y_edges.length - 1).step(2) do |j|
        x = x_edges[i]
        y = y_edges[j]
        w = x_edges[i + 1] - x
        h = y_edges[j + 1] - y
        
        @blocks << Block.new(x: x, y: y, w: w, h: h) if w > 30 && h > 30
      end
    end
  end

  def generate_buildings
    margin = ROAD_SUB_WIDTH + 1
    
    @buildings = all_leaf_blocks.filter_map do |block|
      bx, by = block.x + margin, block.y + margin
      bw, bh = block.w - margin * 2, block.h - margin * 2
      
      Building.new(x: bx, y: by, w: bw, h: bh) if bw >= BUILDING_MIN_SIZE && bh >= BUILDING_MIN_SIZE
    end.sort_by(&:sort_key)
  end
end

def setup
  createCanvas(CANVAS_SIZE, CANVAS_SIZE)
  colorMode(HSB, 360, 255, 255, 255)
  $city = City.new
end

def draw
  background(240, 40, 15)
  
  case $city.phase
  when PHASE_MAIN_ROADS then draw_phase_main_roads
  when PHASE_SUBDIVIDE then draw_phase_subdivide
  when PHASE_BUILDINGS then draw_phase_buildings
  when PHASE_COMPLETE then draw_phase_complete
  end
end

def draw_phase_main_roads
  $city.phase_progress += SPEED_MAIN_ROADS
  
  blendMode(ADD)
  $city.main_roads.each.with_index do |road, i|
    progress = calculate_progress($city.phase_progress, delay: i * 0.15, speed: 1.5)
    next if progress <= 0
    
    coords = road.draw_partial(ease_out_cubic(progress))
    draw_road_segment(*coords)
  end
  blendMode(BLEND)
  
  check_phase_transition($city.main_roads.size, 0.15)
end

def draw_phase_subdivide
  $city.phase_progress += SPEED_SUBDIVIDE
  
  draw_main_roads
  
  all_blocks = $city.all_leaf_blocks
  noFill
  
  all_blocks.each.with_index do |block, i|
    progress = calculate_progress($city.phase_progress, delay: i * 0.008, speed: 1.5)
    block.draw_progress = ease_out_cubic(progress)
    next if block.draw_progress <= 0
    
    draw_block_border(block)
  end
  
  check_phase_transition(all_blocks.size, 0.008)
end

def draw_phase_buildings
  $city.phase_progress += SPEED_BUILDINGS
  
  draw_all_roads
  
  $city.buildings.each.with_index do |building, i|
    progress = calculate_progress($city.phase_progress, delay: i * 0.006, speed: 1.2)
    building.grow_progress = ease_in_out_quad(progress)
    draw_building(building)
  end
  
  check_phase_transition($city.buildings.size, 0.006, extra_wait: 1.0)
end

def draw_phase_complete
  draw_all_roads
  $city.buildings.each { |b| draw_building(b) }
end

def calculate_progress(phase_progress, delay:, speed:)
  ((phase_progress - delay) * speed).clamp(0, 1)
end

def check_phase_transition(count, delay_factor, extra_wait: 0.8)
  last_delay = (count - 1) * delay_factor
  $city.advance_phase if $city.phase_progress >= last_delay + extra_wait
end

def draw_road_segment(x1, y1, x2, y2)
  [[16, 25], [10, 50], [5, 100], [2, 220]].each do |w, alpha|
    stroke(*ROAD_COLOR_GLOW, alpha)
    strokeWeight(ROAD_MAIN_WIDTH + w)
    line(x1, y1, x2, y2)
  end
end

def draw_block_border(block)
  alpha = (block.draw_progress * 180).to_i
  w = block.w * block.draw_progress
  h = block.h * block.draw_progress

  blendMode(ADD)

  stroke(*ROAD_COLOR_GLOW, alpha * 0.25)
  strokeWeight(ROAD_SUB_WIDTH + 3)
  rect(block.x, block.y, w, h)

  stroke(*ROAD_COLOR_GLOW, alpha)
  strokeWeight(ROAD_SUB_WIDTH)
  rect(block.x, block.y, w, h)

  blendMode(BLEND)
end

def draw_main_roads
  blendMode(ADD)
  $city.main_roads.each { |road| draw_road_segment(road.x1, road.y1, road.x2, road.y2) }
  blendMode(BLEND)
end

def draw_all_roads
  draw_main_roads
  
  noFill
  $city.all_leaf_blocks.each { |block| draw_block_border_full(block) }
end

def draw_block_border_full(block)
  blendMode(ADD)
  
  stroke(*ROAD_COLOR_GLOW, 45)
  strokeWeight(ROAD_SUB_WIDTH + 3)
  rect(block.x, block.y, block.w, block.h)
  
  stroke(*ROAD_COLOR_GLOW, 180)
  strokeWeight(ROAD_SUB_WIDTH)
  rect(block.x, block.y, block.w, block.h)
  
  blendMode(BLEND)
end

def draw_building(building)
  return if building.grow_progress <= 0
  return if building.current_floors < 1
  
  building.current_floors.times do |floor|
    draw_building_floor(building, floor)
  end
end

def draw_building_floor(building, floor)
  offset = floor * BUILDING_FLOOR_OFFSET

  bx = building.x + offset
  by = building.y + offset
  bw = building.w - offset * 2
  bh = building.h - offset * 2

  return if bw < 4 || bh < 4

  brightness = 0.3 + (floor.to_f / building.floors) * 0.7
  alpha = (brightness * 255 * building.grow_progress).to_i

  blendMode(ADD)

  fill(BUILDING_COLOR_BASE[0], BUILDING_COLOR_BASE[1], (BUILDING_COLOR_BASE[2] * brightness).to_i, alpha * 0.4)
  noStroke
  rect(bx, by, bw, bh)

  noFill
  stroke(BUILDING_COLOR_GLOW[0], BUILDING_COLOR_GLOW[1], (BUILDING_COLOR_GLOW[2] * brightness).to_i, alpha * 0.6)
  strokeWeight(1)
  rect(bx, by, bw, bh)

  blendMode(BLEND)
end

def mousePressed
  $city = City.new
end