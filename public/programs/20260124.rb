# Genuary Day 24: Perfectionist's nightmare
# Hexagonal tiles falling from corners to center
# v2: Fix sleep issue - use timer-based reset

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  @hex_size = 30
  @tiles = []
  
  # Generate hexagonal grid
  h = @hex_size * sqrt(3)
  
  row = 0
  y = -h
  while y < height + h
    x_offset = (row % 2 == 0) ? 0 : @hex_size * 1.5
    x = -@hex_size * 3 + x_offset
    
    while x < width + @hex_size * 3
      # Distance from nearest corner (normalized 0-1, 0=corner, 1=center)
      corner_distances = [
        sqrt(x**2 + y**2),
        sqrt((x - width)**2 + y**2),
        sqrt(x**2 + (y - height)**2),
        sqrt((x - width)**2 + (y - height)**2)
      ]
      min_corner_dist = corner_distances.min
      max_possible = sqrt((width/2)**2 + (height/2)**2)
      normalized_dist = min_corner_dist / max_possible
      
      @tiles << {
        x: x,
        y: y,
        base_y: y,
        dist: normalized_dist,
        fall_start: nil,
        falling: false,
        fallen: false,
        velocity: 0,
        hue: 200 + rand(-20..20)
      }
      
      x += @hex_size * 3
    end
    
    y += h / 2
    row += 1
  end
  
  @start_time = nil
  @reset_time = nil
end

def draw
  background(220, 15, 15)
  
  # リセット待ち状態
  if @reset_time
    if millis - @reset_time > 2000
      reset_tiles
      @reset_time = nil
      @start_time = millis
    end
    return
  end
  
  @start_time ||= millis
  elapsed = (millis - @start_time) / 1000.0
  
  # 侵食の進行（0→1、約8秒で完了）
  erosion_progress = [elapsed / 8.0, 1.0].min
  
  @tiles.each do |tile|
    # このタイルが落ち始めるタイミング
    fall_threshold = tile[:dist]
    
    if erosion_progress > fall_threshold && !tile[:falling] && !tile[:fallen]
      tile[:falling] = true
      tile[:fall_start] = millis
    end
    
    if tile[:falling]
      # 落下アニメーション
      fall_time = (millis - tile[:fall_start]) / 1000.0
      tile[:y] = tile[:base_y] + 0.5 * 800 * fall_time**2
      
      if tile[:y] > height + @hex_size * 2
        tile[:fallen] = true
        tile[:falling] = false
      end
    end
    
    next if tile[:fallen]
    
    # Draw hexagon
    push
    translate(tile[:x], tile[:y])
    
    fill(tile[:hue], 50, 80)
    stroke(tile[:hue], 60, 60)
    strokeWeight(2)
    
    beginShape
    6.times do |i|
      angle = PI / 6 + i * PI / 3
      hx = cos(angle) * @hex_size
      hy = sin(angle) * @hex_size
      vertex(hx, hy)
    end
    endShape(CLOSE)
    
    pop
  end
  
  # 全て落ちたらリセット待ちへ
  if @tiles.all? { |t| t[:fallen] }
    @reset_time = millis
  end
end

def reset_tiles
  @tiles.each do |t|
    t[:y] = t[:base_y]
    t[:falling] = false
    t[:fallen] = false
    t[:velocity] = 0
    t[:fall_start] = nil
  end
end