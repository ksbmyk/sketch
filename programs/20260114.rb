# GENUARY 2026 jan14 "Everything fits perfectly."
# https://genuary.art/prompts

COLORS = [
  [200, 235, 245],  # 最も薄い
  [160, 215, 235],
  [120, 195, 220],
  [80, 175, 205],   # ターコイズ
  [55, 155, 185],
  [35, 135, 165],
  [20, 115, 145],   # 最も暗い
].freeze

CELL_SIZE = 100

def setup
  createCanvas(700, 700)
  noLoop
end

def draw
  background(255)
  noStroke
  
  # キャンバスを覆うようにタイルを配置
  (-1..7).each do |row|
    (-1..7).each do |col|
      draw_islamic_tile(col * CELL_SIZE, row * CELL_SIZE)
    end
  end
end

def draw_islamic_tile(cx, cy)
  push
  translate(cx, cy)
  
  r = CELL_SIZE / 2.0
  
  # 背景の正方形
  fill(20, 115, 145)
  rectMode(CENTER)
  rect(0, 0, CELL_SIZE, CELL_SIZE)
  
  # 8点星
  fill(80, 175, 205)
  draw_8point_star(0, 0, r * 0.9, r * 0.45)
  
  # 中心の八角形
  fill(160, 215, 235)
  draw_octagon(0, 0, r * 0.35)
  
  # 菱形
  fill(55, 155, 185)
  4.times do |i|
    push
    rotate(i * PI / 2)
    draw_corner_diamond(r, r, r * 0.35)
    pop
  end
  
  pop
end

def draw_8point_star(cx, cy, outer_r, inner_r)
  beginShape
  16.times do |i|
    angle = i * PI / 8 - PI / 2
    r = i.even? ? outer_r : inner_r
    vertex(cx + r * cos(angle), cy + r * sin(angle))
  end
  endShape(CLOSE)
end

def draw_octagon(cx, cy, r)
  beginShape
  8.times do |i|
    angle = i * PI / 4 - PI / 8
    vertex(cx + r * cos(angle), cy + r * sin(angle))
  end
  endShape(CLOSE)
end

def draw_corner_diamond(x, y, size)
  beginShape
  vertex(x, y - size)
  vertex(x + size, y)
  vertex(x, y + size)
  vertex(x - size, y)
  endShape(CLOSE)
end
