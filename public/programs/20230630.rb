# ref: https://note.com/aq_kani/n/nedeeeec11c34

$ctx
$lg
def setup
  createCanvas(700, 700)
  angleMode(DEGREES)
  background('#000')
  $ctx = drawingContext
  $lg = $ctx.createLinearGradient(0, 0, 0, height) # グラデーション
  $lg.addColorStop(0, '#2da7ed') # 水色
  $lg.addColorStop(1, '#ede72d') # 黄色
  noLoop
end

def draw
  $ctx.shadowColor = '#fff' # シャドウ色 : 白
  x = 100
  y = 100
  noStroke

  $ctx.shadowBlur = 30
  ellipse(x, y, 10, 10)
  $ctx.shadowBlur = 20  # 描画するたびにシャドウレベルが0に向かって収束するように
  ellipse(x, y, 10, 10) # 複数回描画することで、シャドウを重ねがけする
  $ctx.shadowBlur = 10
  ellipse(x, y, 10, 10)

  10.times do | i |
    pre_x = x
    pre_y = y
    x = rand(20..500)
    y = rand(20..500)
    fill(255)
    $ctx.shadowBlur = 30
    ellipse(x, y, 10, 10)
    $ctx.shadowBlur = 20
    ellipse(x, y, 10, 10)
    $ctx.shadowBlur = 10
    ellipse(x, y, 10, 10)

    strokeWeight(1)
    stroke(255)

    noFill
    if i.odd?
      dx1 = pre_x/2
      dy1 = pre_y/2
      dx2 = x/2
      dy2 = y/2
    else
      dx1 = pre_x*2
      dy1 = pre_y*2
      dx2 = x*2
      dy2 = y*2
    end
    $ctx.shadowBlur = 30
    bezier(pre_x, pre_y, dx1, dy1, dx2, dy2, x, y)
    $ctx.shadowBlur = 20
    bezier(pre_x, pre_y, dx1, dy1, dx2, dy2, x, y)
    $ctx.shadowBlur = 10
    bezier(pre_x, pre_y, dx1, dy1, dx2, dy2, x, y)
  end

  blendMode(MULTIPLY) # 乗算モードに切り替え
  fill(255)
  noStroke()
  $ctx.fillStyle = $lg # 塗りをグラデーションに
  rect(0, 0, width, height) # 全画面に四角を表示
end
