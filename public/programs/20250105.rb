GREID_SIZE = 10
BOX_SIZE = 200

def setup
  createCanvas(700, 700, WEBGL)
  angleMode(DEGREES)
  noLoop
end

def draw
  background(240)
  translate(0, -150)
  
  (GREID_SIZE * 2).times do
    scaling_factor = random(0.5, 1.5)
    draw_cube(BOX_SIZE, scaling_factor)
  end
end

def draw_cube(size, scaling_factor)
  push
  
  scale(scaling_factor)
  stroke(255, 100)
  strokeWeight(1)

  angle = frameCount * 0.5
  rotateX(angle)
  rotateY(angle)

  # 上
  fill(255, 182, 193)
  beginShape
  vertex(0, -size / 2)
  vertex(size / 2, 0)
  vertex(0, size / 2)
  vertex(-size / 2, 0)
  endShape(CLOSE)

  # 右
  fill(144, 238, 144)
  beginShape
  vertex(0, size / 2)
  vertex(size / 2, 0)
  vertex(size / 2, size)
  vertex(0, size + size / 2)
  endShape(CLOSE)

  # 左
  fill(173, 216, 230)
  beginShape
  vertex(0, size / 2)
  vertex(-size / 2, 0)
  vertex(-size / 2, size)
  vertex(0, size + size / 2)
  endShape(CLOSE)

  # 光
  noStroke
  fill(255, 255, 255, 100)
  beginShape
  vertex(0, -size / 2)
  vertex(size / 2, 0)
  vertex(size / 2, size)
  vertex(0, size / 2)
  endShape(CLOSE)

  pop
end
