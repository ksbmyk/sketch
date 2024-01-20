# GENUARY 2024 jan20 "Generative typography."
# https://genuary.art/prompts


def setup() 
  createCanvas(720, 720)
  @text = "GENUARY 2024"
  @font = "Optima"
  @textGraphic = createGraphics(width, height)
  @textGraphic.clear
  @textGraphic.fill(0)
  @textGraphic.textSize(48)
  @textGraphic.textFont(@font)
  @textGraphic.textAlign(CENTER, CENTER)
  @textGraphic.text(@text, width / 2, height / 2)
end

def draw() 
  noLoop
  draw_background

  #image(@textGraphic, 0, 0)

  # 反転
  drawReflection(@textGraphic, 0.5, 25)

  main_text
end

def main_text 
  stroke(255)
  strokeWeight(3)
  noFill
  textSize(48)
  textFont(@font)
  textAlign(CENTER, CENTER)
  text(@text, width / 2, height / 2)
end

def draw_background()
(0..height).each do |y|
    gradient = map(abs(y - height / 2), 0, height / 2, 255, 0)
    stroke(lerpColor(color(0, 120, 255), color(0, 0, 255), gradient.to_f / 255))
    line(0, y, width, y)
end
end

def drawReflection(graphic, alpha, y_offset) 
  cg = createGraphics(width, height)
  cg.background(255)
  cg.translate(0, height + y_offset) # y_offset分下に移動
  cg.scale(1, -1) # y軸を反転
  cg.image(graphic, 0, 0, width, height)
    
  push()
  tint(255, alpha * 255) # 透明度を適用
  cg.filter(BLUR, 5) # ぼかしを適用（10はぼかしの強さ）
  image(cg, 0, 0, width, height) ぼかしたものを描画
end
