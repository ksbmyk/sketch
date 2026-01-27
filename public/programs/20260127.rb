# GENUARY 2026 jan27 "Perfectionist’s nightmare."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  @branches = []
  @fragments = []
  @branches << Branch.new(0, 0, -HALF_PI, 150, 0)
  @state = :growing  # :growing, :complete, :shattering
  @complete_timer = 0
end

def draw
  background(220, 30, 10)
  translate(width / 2, height / 2)
  
  case @state
  when :growing
    update_growing
  when :complete
    @complete_timer += 1
    if @complete_timer > 90
      shatter
      @state = :shattering
    end
    draw_branches
  when :shattering
    update_fragments
    draw_fragments
    
    if @fragments.all?(&:finished?)
      reset_snowflake
    end
  end
  
  draw_branches if @state == :growing
end

def update_growing
  @branches.each(&:update)
  
  new_branches = []
  @branches.each do |branch|
    if branch.can_spawn? && rand < 0.02
      new_branches.concat(branch.spawn)
    end
  end
  @branches.concat(new_branches)
  
  if @branches.all? { |b| b.fully_grown? && b.done_spawning? }
    @state = :complete
  end
end

def draw_branches
  6.times do |i|
    push
    rotate(i * TWO_PI / 6)
    @branches.each(&:display)
    pop
  end
end

def shatter
  @fragments = []
  
  6.times do |i|
    angle_offset = i * TWO_PI / 6
    @branches.each do |branch|
      num_fragments = (branch.current_length / 8).to_i
      num_fragments.times do |j|
        ratio = j.to_f / num_fragments
        
        local_x = branch.start_x + cos(branch.angle) * branch.current_length * ratio
        local_y = branch.start_y + sin(branch.angle) * branch.current_length * ratio
        
        world_x = local_x * cos(angle_offset) - local_y * sin(angle_offset)
        world_y = local_x * sin(angle_offset) + local_y * cos(angle_offset)
        
        @fragments << Fragment.new(world_x, world_y, branch.depth)
      end
    end
  end
end

def update_fragments
  @fragments.each(&:update)
end

def draw_fragments
  @fragments.each(&:display)
end

def reset_snowflake
  @branches = []
  @fragments = []
  @branches << Branch.new(0, 0, -HALF_PI, 150, 0)
  @state = :growing
  @complete_timer = 0
end

class Branch
  attr_reader :depth, :current_length, :start_x, :start_y, :angle
  
  def initialize(x, y, angle, max_length, depth)
    @start_x = x
    @start_y = y
    @angle = angle
    @max_length = max_length
    @depth = depth
    @current_length = 0
    @growth_speed = map(depth, 0, 4, 1.5, 0.5)
    @spawned = false
    @thickness = map(depth, 0, 4, 4, 1)
  end
  
  def update
    if @current_length < @max_length
      @current_length += @growth_speed
      @current_length = [@current_length, @max_length].min
    end
  end
  
  def fully_grown?
    @current_length >= @max_length
  end
  
  def done_spawning?
    @spawned || @depth >= 4
  end
  
  def can_spawn?
    !@spawned && @depth < 4 && @current_length > @max_length * 0.3
  end
  
  def spawn
    @spawned = true
    new_branches = []
    
    num_spawns = map(@depth, 0, 3, 3, 1).to_i
    num_spawns.times do |i|
      ratio = 0.3 + (i * 0.25)
      spawn_x = @start_x + cos(@angle) * @max_length * ratio
      spawn_y = @start_y + sin(@angle) * @max_length * ratio
      
      new_length = @max_length * rand(0.4..0.6)
      
      new_branches << Branch.new(
        spawn_x, spawn_y,
        @angle - PI / 3,
        new_length,
        @depth + 1
      )
    end
    
    new_branches
  end
  
  def display
    end_x = @start_x + cos(@angle) * @current_length
    end_y = @start_y + sin(@angle) * @current_length
    
    hue = map(@depth, 0, 4, 190, 220)
    brightness = map(@depth, 0, 4, 100, 70)
    
    stroke(hue, 40, 100, 20)
    strokeWeight(@thickness + 4)
    line(@start_x, @start_y, end_x, end_y)
    
    stroke(hue, 60, brightness, 90)
    strokeWeight(@thickness)
    line(@start_x, @start_y, end_x, end_y)
  end
end

class Fragment
  def initialize(x, y, depth)
    @x = x
    @y = y
    @size = map(depth, 0, 4, 6, 2)
    @hue = map(depth, 0, 4, 190, 220)
    
    speed = rand(1.0..3.0)
    angle = rand(TWO_PI)
    @vx = cos(angle) * speed
    @vy = sin(angle) * speed
    @gravity = 0.05
    
    @alpha = 90
    @rotation = rand(TWO_PI)
    @rotation_speed = rand(-0.1..0.1)
  end
  
  def update
    @x += @vx
    @y += @vy
    @vy += @gravity
    @vx *= 0.99
    @alpha -= 0.8
    @rotation += @rotation_speed
  end
  
  def display
    return if @alpha <= 0
    
    push
    translate(@x, @y)
    rotate(@rotation)
    
    noStroke
    fill(@hue, 60, 100, @alpha)
    
    beginShape
    vertex(0, -@size)
    vertex(@size * 0.5, @size * 0.5)
    vertex(-@size * 0.5, @size * 0.5)
    endShape(CLOSE)
    pop
  end
  
  def finished?
    @alpha <= 0
  end
end
