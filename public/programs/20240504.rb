def setup
  createCanvas(700, 700)
  background("#ABE1FA")
  noLoop
end

def draw
  20.times.each do 
    push
    translate(rand(0..width), rand(0..height))
    rotate(rand(-1.0..1.0) * PI/4)
    scale(rand(0.3..1.2))
    snow_man
    pop
  end
end

def snow_man
  noStroke
  # 輪郭線
  fill(0)
  ellipse(200, 150, 102)
  ellipse(200, 250, 152)
  # ボディ
  fill(255)
  ellipse(200, 150, 100)
  ellipse(200, 250, 150)
  # 顔
  fill(0)
  ellipse(200-20, 140, 10)
  ellipse(200+20, 140, 10)
  ellipse(200, 160, 20, 5)
end
