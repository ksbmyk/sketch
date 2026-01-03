# GENUARY 2026 jan1 "Fibonacci forever. Create a work that uses the Fibonacci sequence in some way."
# https://genuary.art/prompts

def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  background(0, 0, 5)
  noLoop
end

def draw
  translate(width / 2, height / 2)
  
  draw_concentric_circles(5)
  
  blendMode(ADD)

  # 90°ずつ回転させて4つ描く
  4.times do |i|
    push
    rotate(HALF_PI * i)
    draw_squares_on_spiral(5)
    pop
  end

  blendMode(BLEND)
end

def draw_concentric_circles(s)
  # フィボナッチ数列
  fib = [1, 1]
  10.times { fib << fib[-1] + fib[-2] }

  noFill

  fib.each_with_index do |r, i|
    radius = r * s
    hue = 180 + (i * 4)
    stroke(hue, 40, 40, 20)
    circle(0, 0, radius * 2)
  end
end

def draw_squares_on_spiral(s)
  # フィボナッチ数列
  fib = [1, 1]
  10.times { fib << fib[-1] + fib[-2] }

  cx, cy = 0, 0
  angle = 0

  interval = 30
  
  fib.each_with_index do |r, i|
    radius = r * s
    arc_length = radius * HALF_PI
    num_points = (arc_length / interval).to_i
    
    next if num_points < 1
    
    num_points.times do |j|
      t = j.to_f / num_points
      a = angle + t * HALF_PI
      
      px = cx + radius * cos(a)
      py = cy + radius * sin(a)
      
      hue = 180 + (i * 4)

      # 半透明の塗り
      fill(hue, 60, 70, 15)
      stroke(hue, 50, 90, 40)
      strokeWeight(1.5)
      
      push
      translate(px, py)
      rotate(random(TWO_PI))
      square_size = random(10, 200)
      rectMode(CENTER)
      rect(0, 0, square_size, square_size)
      pop
    end
    
    # 次の円弧の中心を計算
    # 円弧の終点方向に (現在の半径 - 次の半径) だけ移動
    next_radius = (fib[i + 1] || r) * s
    end_angle = angle + HALF_PI
    
    cx = cx + (radius - next_radius) * cos(end_angle)
    cy = cy + (radius - next_radius) * sin(end_angle)
    
    angle = end_angle
  end
end