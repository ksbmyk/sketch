# Langton's Ant
# Rule: white→turn right, black→turn left, flip color, move forward
CELL = 3

def setup
  createCanvas(700, 700)
  background(10, 20, 40)
  colorMode(HSB, 360, 100, 100)

  @grid = (width / CELL).to_i
  @x, @y = @grid / 2, @grid / 2
  @dx, @dy = 0, -1
  @visits = {}
end

def draw
  100.times { step_ant }
end

def step_ant
  px, py = @x * CELL, @y * CELL
  key = [@x, @y]
  visits = @visits[key] || 0
  is_on = visits.odd?
  
  # right: (dx,dy)→(-dy,dx), left: (dx,dy)→(dy,-dx)
  @dx, @dy = is_on ? [@dy, -@dx] : [-@dy, @dx]
  
  @visits[key] = visits + 1
  
  noStroke
  blendMode(ADD)
  fill(200, 80, 30)
  rect(px, py, CELL, CELL)
  
  @x = ((@x + @dx) % @grid).to_i
  @y = ((@y + @dy) % @grid).to_i
end

def mousePressed
  blendMode(BLEND)
  fill(220, 75, 16)
  noStroke
  rect(0, 0, width, height)
  @x, @y = @grid / 2, @grid / 2
  @dx, @dy = 0, -1
  @visits = {}
end