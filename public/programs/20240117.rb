def setup
    createCanvas(600, 600)
    background("#335fa6")
    noLoop
  end
  
  def draw
    stroke(255)
    strokeWeight(10)
    noFill
    
    arabesque_pattern
    
    stroke("#7eaab7")
    strokeWeight(2)
    noFill
    
    arabesque_pattern

    noStroke
    fill("#c7a964")
    circle_pattern
    
  end

def arabesque_pattern
  (0..8).step do |i|
    arabesque(90*i   , 0   , 100, 5, 5)
    arabesque(45+90*i, 75  , 100, 5, 5)
    arabesque(90*i   , 75*2, 100, 5, 5)
    arabesque(45+90*i, 75*3, 100, 5, 5)
    arabesque(90*i   , 75*4, 100, 5, 5)
    arabesque(45+90*i, 75*5, 100, 5, 5)
    arabesque(90*i   , 75*6, 100, 5, 5)
    arabesque(45+90*i, 75*7, 100, 5, 5)
    arabesque(90*i   , 75*8, 100, 5, 5)
  end
end

def circle_pattern
  (0..8).step do |i|
    circle(90*i   , 0, 10)
    circle(45+90*i, 75, 10)
    circle(90*i, 75*2, 10)
    circle(45+90*i, 75*3, 10)
    circle(90*i, 75*4, 10)
    circle(45+90*i, 75*5, 10)
    circle(90*i, 75*6, 10)
    circle(45+90*i, 75*7, 10)
    circle(90*i, 75*8, 10)
  end
end
  
def arabesque(x, y, radius, sides, depth)
  return if depth == 0
  
  beginShape()
  sides.to_i.times do |i|
    angle = map(i, 0, sides, 0, TWO_PI)
    new_x = x + cos(angle) * radius
    new_y = y + sin(angle) * radius
    vertex(new_x, new_y)
    
    next_radius = radius * 0.3 # 反復サイズ
    next_x = x + cos(angle) * next_radius
    next_y = y + sin(angle) * next_radius
    arabesque(next_x, next_y, next_radius, sides, depth - 1)
  end
  endShape(CLOSE)
end
