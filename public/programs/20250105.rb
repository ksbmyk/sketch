GREID_SIZE = 6
BOX_SIZE = 50

def setup
  createCanvas(700, 700)
  angleMode(DEGREES)
  noLoop
end

def draw
  background(255)
  translate(width / 2, height / 2)

  (-GREID_SIZE).step(GREID_SIZE, 1) do |x|
    (-GREID_SIZE).step(GREID_SIZE, 1) do |y|
      xpos = (x - y) * BOX_SIZE * 0.5 # アイソメトリックのX座標
      ypos = (x + y) * BOX_SIZE * 0.25 # アイソメトリックのY座標
      draw_cube(xpos, ypos, BOX_SIZE)
    end
  end
end

# 立方体を描画する関数
def draw_cube(x, y, size)
  push
  translate(x, y)

  # 上
  fill(200, 220, 255)
  stroke(0)
  beginShape
  vertex(0, -size / 2)
  vertex(size / 2, 0)
  vertex(0, size / 2)
  vertex(-size / 2, 0)
  endShape(CLOSE)

  # 右
  fill(180, 200, 240)
  beginShape
  vertex(0, size / 2)
  vertex(size / 2, 0)
  vertex(size / 2, size)
  vertex(0, size + size / 2)
  endShape(CLOSE)

  # 左
  fill(160, 180, 220)
  beginShape
  vertex(0, size / 2)
  vertex(-size / 2, 0)
  vertex(-size / 2, size)
  vertex(0, size + size / 2)
  endShape(CLOSE)

  pop
end
