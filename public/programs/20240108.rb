# GENUARY 2024 jan8
# https://genuary.art/prompts
# https://wagtail.cds.tohoku.ac.jp/coda/python/misc/p-misc-lorenz-model.html
# https://www.isc.meiji.ac.jp/~random/lecture/2017-comp2/miyake.html

def setup
    @x = 0.01
    @y = 0
    @z = 0
    @dt = 0.01
    @sigma = 10
    @rho = 28
    @beta = 8/3
    
    createCanvas(800, 600, WEBGL) # 三次元描画
    background(0)

  end
  
  def draw
    translate(0, 0, -80)
    
    # ローレンツ方程式
    dx = (@sigma * (@y - @x)) * @dt
    dy = (@x * (@rho - @z) - @y) * @dt
    dz = (@x * @y - @beta * @z) * @dt
    
    @x += dx
    @y += dy
    @z += dz
    
    px = map(@x, -20, 20, -width / 2, width / 2)
    py = map(@y, -20, 20, -height / 2, height / 2)
    pz = map(@z, 0, 40, -200, 200)
  
    from = color(255, 0, 0) # 色の開始点
    to = color(0, 0, 255) # 色の終了点
    interColor = lerpColor(from, to, map(pz, -200, 200, 0, 1))

    fill(interColor)
    ellipse(px, py, 3, 3)
  end
 