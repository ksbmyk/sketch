# GENUARY 2024 jan8
# https://genuary.art/prompts
# https://wagtail.cds.tohoku.ac.jp/coda/python/misc/p-misc-lorenz-model.html

def setup
    @x = 0.01
    @y = 0
    @z = 0
    @dt = 0.01
    @sigma = 10
    @rho = 28
    @beta = 8/3
    
    createCanvas(800, 600, WEBGL) # 三次元描画
    background(255)
    stroke(0)
  end
  
  def draw
    translate(0, 0, -80)
    
    #scale(2)
    
    # ローレンツ方程式
    dx = (@sigma * (@y - @x)) * @dt
    dy = (@x * (@rho - @z) - @y) * @dt
    dz = (@x * @y - @beta * @z) * @dt
    
    @x += dx
    @y += dy
    @z += dz
    
    px = map(@x, -20, 20, -width / 2, width / 2)
    py = map(@y, -20, 20, -height / 2, height / 2)
    pz = map(@z, 0, 40, -200, 200);
  
    point(px, py, pz)
  end
 