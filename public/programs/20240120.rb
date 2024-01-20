# GENUARY 2024 jan20 "Generative typography."
# https://genuary.art/prompts


def setup() 
  createCanvas(400, 400)
  @textGraphic = createGraphics(width, height)
  @textGraphic.pixelDensity(1)
  @textGraphic.background(255)
  @textGraphic.fill(0)
  @textGraphic.textSize(48)
  @textGraphic.textFont("Arial")
  @textGraphic.textAlign(CENTER, CENTER)
  
  @textGraphic.text("Hello World", width / 2, height / 2)
end

def draw() 
  noLoop()
  background(200) #背景色

  #オリジナルのテキストを描画
  image(@textGraphic, 0, 0)

  # テキストの下に反転したコピーを描画（位置をより下に移動）
  drawReflection(@textGraphic, 0.5, 20) # 透明度を0.5にして反転コピーを描画
end

def drawReflection(graphic, alpha, yOffset) 
  pg = createGraphics(width, height)# 新しいPGを作成
  pg.background(255)
  pg.translate(0, height + yOffset)# y軸を反転し、yOffset分下に移動
  pg.scale(1, -1) # y軸を反転
  pg.image(graphic, 0, 0, width, height)# 反転コピーを描画
  
  push();
  tint(255, alpha * 255)# 透明度を適用
  image(pg, 0, 0, width, height)# PGを描画
  pop()
end
