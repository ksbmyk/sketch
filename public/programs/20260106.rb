def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  rectMode(CENTER)
  
  @light_on = true 
  @cols = 8
  @rows = 8
  @cell_size = 700.0 / @cols
  
  @phase_offsets = @cols.times.map do
    @rows.times.map { random(TWO_PI) }
  end
end

def draw
  if @light_on
    background(0, 0, 100)  # 白背景
    blendMode(MULTIPLY)
  else
    background(0, 0, 0)    # 黒背景
    blendMode(ADD)
  end
  
  noStroke
  
  @cols.times do |col|
    @rows.times do |row|
      x = col * @cell_size + @cell_size / 2
      y = row * @cell_size + @cell_size / 2
      
      phase_offset = @phase_offsets[col][row]
      
      # 拡縮
      scale_factor = map(sin(frameCount * 0.03 + phase_offset), -1, 1, 0.3, 1.3)
      rect_size = @cell_size * scale_factor
      
      fill(190, 80, 90, 140)
      rect(x, y, rect_size, rect_size)
    end
  end
  
  blendMode(BLEND)
end

def mousePressed
  @light_on = !@light_on
end
