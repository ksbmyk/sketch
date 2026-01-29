# GENUARY 2026 jan27 "Genetic evolution and mutation."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  
  @grid_size = 4
  @cell_size = 700 / @grid_size
  @target_radius = @cell_size * 0.35
  @generation = 0
  
  @pause_duration = 60
  @fadeout_duration = 40
  @transform_duration = 30
  @settle_duration = 60
  @ghost_duration = 90
  @bright_duration = 60
  
  @phase = :pause
  @phase_frame = 0
  
  @population = @grid_size * @grid_size
  @individuals = @population.times.map { create_random_individual(0) }
  
  @alphas = [100.0] * @population
  @positions = []
  @grid_size.times do |row|
    @grid_size.times do |col|
      @positions << { x: col * @cell_size + @cell_size / 2, y: row * @cell_size + @cell_size / 2 }
    end
  end
  
  @parent_ghosts = [nil] * @population
  @ghost_timers = [0] * @population
  @bright_timers = [0] * @population
  
  @survivors = []
  @dead = []
  @transform_data = []
end

def draw
  background(220, 10, 15)
  
  draw_target_circles
  
  case @phase
  when :pause
    draw_pause
  when :fadeout
    draw_fadeout
  when :transform
    draw_transform
  when :settle
    draw_settle
  end
  
  @phase_frame += 1
end

def draw_target_circles
  noFill
  stroke(200, 30, 40, 30)
  strokeWeight(1)
  
  @positions.each do |pos|
    ellipse(pos[:x], pos[:y], @target_radius * 2, @target_radius * 2)
  end
end

def draw_pause
  @population.times do |i|
    cx = @positions[i][:x]
    cy = @positions[i][:y]
    
    if @ghost_timers[i] > 0 && @parent_ghosts[i]
      ghost_alpha = (@ghost_timers[i].to_f / @ghost_duration) * 50
      draw_ghost(@parent_ghosts[i], cx, cy, ghost_alpha)
      @ghost_timers[i] -= 1
    end
    
    bright_factor = 0
    if @bright_timers[i] > 0
      bright_factor = @bright_timers[i].to_f / @bright_duration
      @bright_timers[i] -= 1
    end
    
    draw_individual(@individuals[i], cx, cy, @alphas[i], bright_factor)
  end
  
  start_fadeout if @phase_frame >= @pause_duration
end

def draw_fadeout
  @population.times do |i|
    cx = @positions[i][:x]
    cy = @positions[i][:y]
    
    if @ghost_timers[i] > 0 && @parent_ghosts[i]
      ghost_alpha = (@ghost_timers[i].to_f / @ghost_duration) * 50
      draw_ghost(@parent_ghosts[i], cx, cy, ghost_alpha)
      @ghost_timers[i] -= 1
    end
    
    bright_factor = 0
    if @bright_timers[i] > 0
      bright_factor = @bright_timers[i].to_f / @bright_duration
      @bright_timers[i] -= 1
    end
    
    draw_individual(@individuals[i], cx, cy, @alphas[i], bright_factor)
  end
  
  t = [@phase_frame.to_f / @fadeout_duration, 1.0].min
  @dead.each do |idx|
    @alphas[idx] = 100.0 * (1.0 - ease_in(t))
  end
  
  start_transform if @phase_frame >= @fadeout_duration
end

def draw_transform
  t = [@phase_frame.to_f / @transform_duration, 1.0].min
  eased_t = ease_out(t)
  
  @survivors.each do |idx|
    cx = @positions[idx][:x]
    cy = @positions[idx][:y]
    draw_individual(@individuals[idx], cx, cy, 100, eased_t)
  end
  
  @transform_data.each do |data|
    idx = data[:idx]
    parent = data[:parent]
    child = data[:child]
    cx = @positions[idx][:x]
    cy = @positions[idx][:y]
    
    draw_ghost(parent, cx, cy, 50)
    draw_individual(child, cx, cy, 100 * eased_t, eased_t)
  end
  
  start_settle if @phase_frame >= @transform_duration
end

def draw_settle
  @population.times do |i|
    cx = @positions[i][:x]
    cy = @positions[i][:y]
    
    if @ghost_timers[i] > 0 && @parent_ghosts[i]
      ghost_alpha = (@ghost_timers[i].to_f / @ghost_duration) * 50
      draw_ghost(@parent_ghosts[i], cx, cy, ghost_alpha)
      @ghost_timers[i] -= 1
    end
    
    bright_factor = 0
    if @bright_timers[i] > 0
      bright_factor = @bright_timers[i].to_f / @bright_duration
      @bright_timers[i] -= 1
    end
    
    draw_individual(@individuals[i], cx, cy, @alphas[i], bright_factor)
  end
  
  if @phase_frame >= @settle_duration
    @generation += 1
    @phase = :pause
    @phase_frame = 0
  end
end

def start_fadeout
  sorted = @individuals.each_with_index
    .map { |ind, i| [i, fitness(ind)] }
    .sort_by { |_, f| -f }
  
  @survivors = sorted.take(@population / 2).map(&:first)
  @dead = sorted.drop(@population / 2).map(&:first)
  
  @phase = :fadeout
  @phase_frame = 0
end

def start_transform
  @transform_data = @survivors.each_with_index.map do |survivor_idx, i|
    parent = @individuals[survivor_idx]
    {
      idx: @dead[i],
      parent: deep_copy(parent),
      child: mutate(deep_copy(parent), @generation + 1)
    }
  end
  
  @phase = :transform
  @phase_frame = 0
end

def start_settle
  @transform_data.each do |data|
    @individuals[data[:idx]] = data[:child]
    @alphas[data[:idx]] = 100.0
    @parent_ghosts[data[:idx]] = data[:parent]
    @ghost_timers[data[:idx]] = @ghost_duration
    @bright_timers[data[:idx]] = @bright_duration
  end
  
  @survivors.each { |idx| @bright_timers[idx] = @bright_duration }
  
  @phase = :settle
  @phase_frame = 0
end

def draw_individual(ind, cx, cy, alpha, bright_factor = 0)
  sorted_vertices = ind[:vertices].sort_by { |v| v[:angle] }
  
  extra_brightness = bright_factor * 30
  adjusted_brightness = [ind[:brightness] + extra_brightness, 100].min
  adjusted_saturation = ind[:saturation] * (1 - bright_factor * 0.3)
  
  fill(ind[:hue], adjusted_saturation, adjusted_brightness, alpha * 0.8)
  stroke(ind[:hue], adjusted_saturation, [100, adjusted_brightness + 10].min, alpha)
  strokeWeight(2)
  
  beginShape
  sorted_vertices.each do |v|
    x = cx + cos(v[:angle]) * v[:radius]
    y = cy + sin(v[:angle]) * v[:radius]
    vertex(x, y)
  end
  endShape(CLOSE)
  
  return unless bright_factor > 0.3
  
  noFill
  stroke(ind[:hue], 30, 100, alpha * bright_factor * 0.3)
  strokeWeight(4)
  beginShape
  sorted_vertices.each do |v|
    x = cx + cos(v[:angle]) * v[:radius]
    y = cy + sin(v[:angle]) * v[:radius]
    vertex(x, y)
  end
  endShape(CLOSE)
end

def draw_ghost(ind, cx, cy, alpha)
  sorted_vertices = ind[:vertices].sort_by { |v| v[:angle] }
  
  noFill
  stroke(0, 0, 70, alpha)
  strokeWeight(1)
  
  beginShape
  sorted_vertices.each do |v|
    x = cx + cos(v[:angle]) * v[:radius]
    y = cy + sin(v[:angle]) * v[:radius]
    vertex(x, y)
  end
  endShape(CLOSE)
  
  fill(0, 0, 80, alpha * 1.2)
  noStroke
  sorted_vertices.each do |v|
    x = cx + cos(v[:angle]) * v[:radius]
    y = cy + sin(v[:angle]) * v[:radius]
    ellipse(x, y, 5, 5)
  end
end

def ease_in(t)
  t * t
end

def ease_out(t)
  1 - (1 - t) ** 2
end

def create_random_individual(birth_gen)
  num_vertices = rand(3..6)
  
  vertices = num_vertices.times.map do |i|
    {
      angle: (TWO_PI / num_vertices) * i + rand(-0.3..0.3),
      radius: rand(30.0..70.0)
    }
  end
  
  {
    vertices: vertices,
    hue: rand(180.0..280.0),
    saturation: rand(50.0..90.0),
    brightness: rand(60.0..95.0),
    birth_generation: birth_gen
  }
end

def fitness(ind)
  vertices = ind[:vertices]
  n = vertices.length
  
  ideal_vertices = 12
  vertex_diff = (n - ideal_vertices).abs
  vertex_score = 1.0 / (1.0 + vertex_diff * 0.2)
  
  radii = vertices.map { |v| v[:radius] }
  avg_radius = radii.sum / n
  radius_variance = radii.map { |r| (r - avg_radius) ** 2 }.sum / n
  radius_consistency = 1.0 / (1.0 + radius_variance / 50.0)
  
  radius_diff = (avg_radius - @target_radius).abs
  radius_match = 1.0 / (1.0 + radius_diff / 30.0)
  
  sorted_angles = vertices.map { |v| v[:angle] }.sort
  expected_gap = TWO_PI / n
  angle_diffs = n.times.map do |i|
    next_i = (i + 1) % n
    gap = sorted_angles[next_i] - sorted_angles[i]
    gap += TWO_PI if gap <= 0
    (gap - expected_gap).abs
  end
  angle_variance = angle_diffs.sum / n
  angle_consistency = 1.0 / (1.0 + angle_variance * 3)
  
  vertex_score * 0.35 + radius_consistency * 0.25 + radius_match * 0.15 + angle_consistency * 0.25
end

def deep_copy(ind)
  {
    vertices: ind[:vertices].map(&:dup),
    hue: ind[:hue],
    saturation: ind[:saturation],
    brightness: ind[:brightness],
    birth_generation: ind[:birth_generation]
  }
end

def mutate(ind, new_birth_gen)
  mutation_rate = 0.3
  
  ind[:vertices].each do |v|
    next unless rand < mutation_rate
    v[:angle] += rand(-0.1..0.1)
    v[:radius] = (v[:radius] + rand(-5.0..5.0)).clamp(25.0, 75.0)
  end
  
  if rand < 0.5 && ind[:vertices].length < 16
    sorted = ind[:vertices].sort_by { |v| v[:angle] }
    max_gap = 0
    insert_after = 0
    
    sorted.length.times do |i|
      next_i = (i + 1) % sorted.length
      gap = sorted[next_i][:angle] - sorted[i][:angle]
      gap += TWO_PI if gap <= 0
      if gap > max_gap
        max_gap = gap
        insert_after = i
      end
    end
    
    next_i = (insert_after + 1) % sorted.length
    new_angle = sorted[insert_after][:angle] + max_gap / 2
    avg_radius = (sorted[insert_after][:radius] + sorted[next_i][:radius]) / 2
    
    ind[:vertices] << { angle: new_angle, radius: avg_radius + rand(-3.0..3.0) }
  end
  
  if rand < 0.05 && ind[:vertices].length > 4
    ind[:vertices].delete_at(rand(ind[:vertices].length))
  end
  
  ind[:hue] = (ind[:hue] + rand(-10.0..10.0)).clamp(180.0, 280.0) if rand < mutation_rate
  ind[:saturation] = (ind[:saturation] + rand(-10.0..10.0)).clamp(40.0, 100.0) if rand < mutation_rate
  ind[:brightness] = (ind[:brightness] + rand(-10.0..10.0)).clamp(50.0, 100.0) if rand < mutation_rate
  ind[:birth_generation] = new_birth_gen
  
  ind
end
