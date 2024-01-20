# GENUARY 2024 jan20 "Generative typography."
# https://genuary.art/prompts


def setup
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

def draw
    noLoop
    draw_background
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

def draw_background
  (0..height).each do |y|
    gradient = map(abs(y - height / 2), 0, height / 2, 255, 0)
    stroke(lerpColor(color(0, 120, 255), color(0, 0, 255), gradient.to_f / 255))
    line(0, y, width, y)
  end
  noStroke
  fill(255, 255, 255, 100)
  rect(0, 0, width, height)
end

def drawReflection(graphic, alpha, y_offset) 
  cg = createGraphics(width, height)
  cg.clear
  cg.image(graphic, 0, 0, width, height)
    
  push
  tint(255, alpha * 255) 
  cg.filter(BLUR, 5) # ぼかし
  image(cg, 0, y_offset, width, height)
  pop
end
