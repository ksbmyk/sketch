# GENUARY 2026 jan20 "One line. An artwork that is made of a single line only."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  background(20)
  colorMode(HSB, 360, 100, 100, 100)
  blendMode(ADD)
  noFill
  
  # ハイポトコロイドのパラメータ
  @base_radius   = 220.0
  @rolling_radius = 34.0
  @pen_distance   = 110.0
  
  @angle = 0.0
  @prev_x = nil
  @prev_y = nil
  @angle_step = 0.001
  @steps_per_frame = 30
  
  # 必要な回転数を計算
  gcd = @base_radius.to_i.gcd(@rolling_radius.to_i)
  @max_angle = 2 * PI * @rolling_radius / gcd
end

def draw
  translate(width / 2, height / 2)
  
  return if @angle > @max_angle
  
  @steps_per_frame.times do
    break if @angle > @max_angle
    
    # ハイポトコロイド
    radius_diff = @base_radius - @rolling_radius
    angle_ratio = radius_diff / @rolling_radius
    
    x = radius_diff * cos(@angle) + @pen_distance * cos(angle_ratio * @angle)
    y = radius_diff * sin(@angle) - @pen_distance * sin(angle_ratio * @angle)
    
    if @prev_x && @prev_y

      stroke(200, 80, 60, 5)
      strokeWeight(12)
      line(@prev_x, @prev_y, x, y)
      
      stroke(200, 70, 70, 10)
      strokeWeight(6)
      line(@prev_x, @prev_y, x, y)
      
      stroke(195, 50, 90, 20)
      strokeWeight(3)
      line(@prev_x, @prev_y, x, y)
      
      stroke(190, 30, 100, 60)
      strokeWeight(1.5)
      line(@prev_x, @prev_y, x, y)
    end
    
    @prev_x = x
    @prev_y = y
    @angle += @angle_step
  end
end
