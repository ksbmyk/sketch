def setup
  createCanvas(500, 500)
  noLoop
end

def draw
  background(255)

  noStroke

  #x1 : グラデーションの中心点の x 座標
  #y1 : グラデーションの中心点の y 座標
  #r1 : グラデーションの開始点（中心点からの距離）
  #x2 : グラデーションの外側の円の中心点の x 座標
  #y2 : グラデーションの外側の円の中心点の y 座標
  #r2 : グラデーションの終了点（外側の円の半径）
  x = 100
  y = 100
  gradient = drawingContext.createRadialGradient(x, y, 30, x, y, 50)
  # 参考 https://webgradients.com/
  gradient.addColorStop(0, color(150, 251, 196))
  gradient.addColorStop(1, color(249, 245, 134))
  drawingContext.fillStyle = gradient
  circle(x, y , 120)

  x = 250
  y = 100
  gradient = drawingContext.createRadialGradient(x + 20, y, 30, x + 20, y + 10, 50)
  gradient.addColorStop(0, color(150, 251, 196))
  gradient.addColorStop(1, color(249, 245, 134))
  drawingContext.fillStyle = gradient
  circle(x, y , 120)

  x = 100
  y = 250
  gradient = drawingContext.createRadialGradient(x-20, y, 30, x-20, y+10, 50)
  gradient.addColorStop(0, color(150, 251, 196))
  gradient.addColorStop(1, color(249, 245, 134))
  drawingContext.fillStyle = gradient
  circle(x, y , 120)

  x = 100
  y = 250
  gradient = drawingContext.createRadialGradient(x - 20, y, 30, x - 20, y + 10, 50)
  gradient.addColorStop(0, color(150, 251, 196))
  gradient.addColorStop(1, color(249, 245, 134))
  drawingContext.fillStyle = gradient
  circle(x, y , 120)


  x = 250
  y = 250
  gradient = drawingContext.createRadialGradient(x, y, 20, x , y, 60)
  gradient.addColorStop(0, color(150, 251, 196))
  gradient.addColorStop(0.5, color(249, 245, 134))
  gradient.addColorStop(1, color(150, 251, 196))
  drawingContext.fillStyle = gradient
  circle(x, y , 120)
end