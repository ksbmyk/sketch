def setup
  createCanvas(700, 700)
  background(255)
  noLoop
end

def draw
  translate(width / 2, height / 2)
  noFill
  stroke(0)
  strokeWeight(2)
  
  # フィボナッチ数列
  fib = [1, 1]
  10.times { fib << fib[-1] + fib[-2] }
  
  s = 5  # scale factor
  
  cx, cy = 0, 0
  angle = 0
  
  fib.each_with_index do |r, i|
    radius = r * s
    
    arc(cx, cy, radius * 2, radius * 2, angle, angle + HALF_PI)
    
    # 次の円弧の中心を計算
    # 円弧の終点方向に (現在の半径 - 次の半径) だけ移動
    next_radius = (fib[i + 1] || r) * s
    end_angle = angle + HALF_PI
    
    cx = cx + (radius - next_radius) * cos(end_angle)
    cy = cy + (radius - next_radius) * sin(end_angle)
    
    angle = end_angle
  end
end