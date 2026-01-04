def setup
  createCanvas(700, 700)
  colorMode(HSB, 360, 100, 100, 100)
  noFill
  stroke(190, 80, 100)
  strokeWeight(2)
  @time = 0.0
end

def draw
  background(0)
  translate(width / 2, height / 2)
  
  @time += 0.02
 
  a = 3
  b = 4
  phase = @time  # 位相が時間で変化
  
  margin = 70                                 # 画面端からの余白
  amplitude = width / 2 - margin              # 振幅
  angle_step = 0.5                            # 角度の刻み（度）
  num_points = (360 / angle_step).to_i + 1    # 点の数
  
  beginShape
  num_points.times do |i|
    angle = radians(i * angle_step)
    x = amplitude * sin(a * angle + phase)  # 位相を加算
    y = amplitude * sin(b * angle)
    vertex(x, y)
  end
  endShape
end