GREID_SIZE = 6
BOX_SIZE = 50

def setup
  createCanvas(700, 700, WEBGL)
  angleMode(DEGREES)
  noLoop
end

def draw
  background(255)

  (-GREID_SIZE).step(GREID_SIZE, 1) do |x|
    (-GREID_SIZE).step(GREID_SIZE, 1) do |y|
      xpos = (x - y) * BOX_SIZE * 0.5 # アイソメトリックのX座標
      ypos = (x + y) * BOX_SIZE * 0.25 # アイソメトリックのY座標
      scaling_factor = random(0.5, 1.5)
      draw_cube(xpos, ypos, BOX_SIZE, scaling_factor)
    end
  end
end

def draw_cube(x, y, size, scaling_factor)
  push
  translate(x, y)
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
