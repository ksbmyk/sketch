# Langton's Ant
# Rule: white→turn right, black→turn left, flip color, move forward
CELL = 3
def setup
  createCanvas(700, 700)
  background(10, 20, 40)

  @grid = (width / CELL).to_i
  @x, @y = @grid / 2, @grid / 2
  @dx, @dy = 0, -1
end

def draw
  100.times { step_ant }
end

def step_ant
  px, py = @x * CELL, @y * CELL
  # get(px, py)で座標のピクセル色を取得、green(...)でその緑成分（0〜255）を抽出 背景色と描画色の区別をする
  is_on = green(get(px, py)) > 100
  
  # right: (dx,dy)→(-dy,dx), left: (dx,dy)→(dy,-dx)
  @dx, @dy = is_on ? [@dy, -@dx] : [-@dy, @dx]
  
  fill(is_on ? color(10, 20, 40) : color(0, 200, 220))
  noStroke
  rect(px, py, CELL, CELL)
  
  @x = ((@x + @dx) % @grid).to_i
  @y = ((@y + @dy) % @grid).to_i
end