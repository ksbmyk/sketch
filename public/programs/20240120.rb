# GENUARY 2024 jan20 "Generative typography."
# https://genuary.art/prompts


def setup() 
  createCanvas(720, 720)
  @textGraphic = createGraphics(width, height)
  @textGraphic.pixelDensity(1)
  #@textGraphic.background(255)
  @textGraphic.clear()
  @textGraphic.fill(0)
  @textGraphic.textSize(48)
  @textGraphic.textFont("Optima")
  @textGraphic.textAlign(CENTER, CENTER)
  @textGraphic.text("Hello World", width / 2, height / 2)
end

def draw() 
  noLoop()
  #background(200) #背景色
  draw_background() # 背景を描画

  #オリジナルのテキストを描画
  image(@textGraphic, 0, 0)

  # テキストの下に反転したコピーを描画（位置をより下に移動）
  drawReflection(@textGraphic, 0.5, 25) # 透明度を0.5にして反転コピーを描画
  stroke(255)
  strokeWeight(1)
  fill(255, 100)
  textSize(48)
  textFont("Optima")
  textAlign(CENTER, CENTER)
  text("Hello World", width / 2, height / 2)
end

def draw_background()
# 青系統のグラデーションを描画
(0..height).each do |y|
    gradient = map(abs(y - height / 2), 0, height / 2, 255, 0)
    stroke(lerpColor(color(0, 120, 255), color(0, 0, 255), gradient.to_f / 255))
    line(0, y, width, y)
end
end

def drawReflection(graphic, alpha, yOffset) 
  pg = createGraphics(width, height)# 新しいPGを作成
  pg.background(255)
  pg.translate(0, height + yOffset) # y軸を反転し、yOffset分下に移動
  pg.scale(1, -1) # y軸を反転
  pg.image(graphic, 0, 0, width, height)# 反転コピーを描画

  push()
  tint(255, alpha * 255)# 透明度を適用
  image(pg, 0, 0, width, height)# PGを描画
  pop()
end
