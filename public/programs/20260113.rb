# GENUARY 2026 jan13 "Self portrait. For example, get started with a very basic human face, a few circles or oval shapes. How far can you improve this by adding features that actually look like you. Try adding eyes, eyelashes, hair, and make a few parameters or colors variable. Even though you are aiming for a self portrait, it might be fun to render some random variations as well."
# https://genuary.art/prompts

GRID_SIZE = 3

# カラフルパレット（各セル用）
PALETTES = [
  { bg: [350, 70, 80], hair: [280, 80, 30], face: [40, 60, 90], skin: [30, 40, 95] },
  { bg: [180, 80, 70], hair: [320, 70, 40], face: [60, 70, 85], skin: [35, 35, 92] },
  { bg: [60, 80, 85], hair: [200, 80, 35], face: [0, 60, 80], skin: [25, 45, 90] },
  { bg: [280, 60, 75], hair: [40, 80, 50], face: [180, 50, 70], skin: [30, 30, 93] },
  { bg: [120, 70, 60], hair: [0, 75, 45], face: [220, 60, 75], skin: [28, 38, 88] },
  { bg: [30, 80, 90], hair: [260, 75, 35], face: [160, 55, 70], skin: [32, 42, 91] },
  { bg: [200, 75, 65], hair: [50, 85, 55], face: [320, 50, 80], skin: [25, 35, 94] },
  { bg: [320, 65, 70], hair: [100, 70, 40], face: [30, 65, 85], skin: [28, 40, 89] },
  { bg: [160, 70, 55], hair: [350, 80, 45], face: [240, 55, 75], skin: [33, 38, 92] },
]

def setup
  createCanvas(700, 700)
  noLoop
  colorMode(HSB, 360, 100, 100, 100)
end

def draw
  background(0)
  
  cell_size = width.to_f / GRID_SIZE
  
  GRID_SIZE.times do |row|
    GRID_SIZE.times do |col|
      x = col * cell_size
      y = row * cell_size

      idx = row * GRID_SIZE + col
      palette = PALETTES[idx]

      # 背景
      fill(palette[:bg][0], palette[:bg][1], palette[:bg][2])
      noStroke
      rect(x, y, cell_size, cell_size)

      # 顔の描画
      center_x = x + cell_size / 2
      center_y = y + cell_size / 2 + 10

      draw_face(center_x, center_y, cell_size * 0.85, palette)
    end
  end
end

def draw_face(x, y, size, palette)
  push
  translate(x, y)

  scale_factor = size / 350.0
  scale(scale_factor)

  hair_color = palette[:hair]
  face_color = palette[:face]
  skin_color = palette[:skin]

  noStroke

  # === 髪（おかっぱ）===
  fill(hair_color[0], hair_color[1], hair_color[2])

  beginShape
  vertex(-120, -80)
  vertex(-130, 0)
  vertex(-130, 100)
  vertex(-120, 170)
  vertex(-60, 170)
  vertex(60, 170)
  vertex(120, 170)
  vertex(130, 100)
  vertex(130, 0)
  vertex(120, -80)
  vertex(80, -120)
  vertex(0, -140)
  vertex(-80, -120)
  endShape(CLOSE)
  
  # === 首 ===
  fill(skin_color[0], skin_color[1], skin_color[2] - 10)
  rectMode(CENTER)
  rect(0, 160, 60, 80, 5)
  
  # === 顔 ===
  fill(skin_color[0], skin_color[1], skin_color[2])
  ellipse(0, 30, 200, 240)
  
  # 前髪（ぱっつん）
  fill(hair_color[0], hair_color[1], hair_color[2])
  beginShape
  vertex(-110, -80)
  vertex(-100, -30)
  vertex(-60, -30)
  vertex(0, -30)
  vertex(60, -30)
  vertex(100, -30)
  vertex(110, -80)
  vertex(80, -110)
  vertex(0, -130)
  vertex(-80, -110)
  endShape(CLOSE)
  
  # === メガネ ===
  stroke(face_color[0], face_color[1] + 20, face_color[2] - 30)
  strokeWeight(6)
  noFill
  rectMode(CENTER)
  rect(-45, 10, 70, 50, 10)
  rect(45, 10, 70, 50, 10)
  line(-10, 10, 10, 10)
  line(-80, 10, -100, 5)
  line(80, 10, 100, 5)
  
  # === 目 ===
  noStroke
  fill(face_color[0], face_color[1], face_color[2] - 40)
  ellipse(-45, 15, 20, 25)
  ellipse(45, 15, 20, 25)
  fill(face_color[0], face_color[1] - 30, face_color[2] + 20)
  ellipse(-42, 12, 6, 6)
  ellipse(48, 12, 6, 6)
  
  # === 鼻 ===
  fill(skin_color[0], skin_color[1] + 10, skin_color[2] - 15)
  triangle(0, 30, -12, 70, 12, 70)
  
  # === 口 ===
  fill(face_color[0], face_color[1] + 10, face_color[2] - 20)
  ellipse(0, 100, 40, 15)

  pop
end
