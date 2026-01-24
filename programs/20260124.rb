# GENUARY 2026 jan24 "Perfectionist’s nightmare."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  @tile_size = 40
  @gap = 4
  @tiles = []
  
  # Generate square grid
  step = @tile_size + @gap
  cols = (width / step).ceil
  rows = (height / step).ceil

  rows.times do |row|
    cols.times do |col|
      x = @gap / 2 + col * step
      y = @gap / 2 + row * step

      # Distance from nearest corner (normalized 0-1, 0=corner, 1=center)
      tile_cx = x + @tile_size / 2.0
      tile_cy = y + @tile_size / 2.0
      
      corner_distances = [
        sqrt(tile_cx**2 + tile_cy**2),
        sqrt((tile_cx - width)**2 + tile_cy**2),
        sqrt(tile_cx**2 + (tile_cy - height)**2),
        sqrt((tile_cx - width)**2 + (tile_cy - height)**2)
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
        hue: 200 + rand(-15..15)
      }
    end
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
      
      if tile[:y] > height + @tile_size
        tile[:fallen] = true
        tile[:falling] = false
      end
    end
    
    next if tile[:fallen]
    
    # Draw square tile
    fill(tile[:hue], 50, 80)
    stroke(tile[:hue], 60, 60)
    strokeWeight(2)
    rect(tile[:x], tile[:y], @tile_size, @tile_size)
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
    t[:fall_start] = nil
  end
end
