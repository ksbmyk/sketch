# GENUARY 2025 jan17 "Design a rug."
# https://genuary.art/prompts

def setup
  createCanvas(600, 600)
  background("#800000")
  noLoop
end
  
def draw
  stroke("#FFBF00")
  strokeWeight(2)
  noFill
  arabesque_pattern

  noStroke
  fill("#FFBF00")
  circle_pattern
  
  stroke("#FFBF00")
  rect(0, 0, width, 70)
  rect(0, height - 70, width, height)
  rect(0, 0, 70, height)
  rect(width - 70, 0, width, height)
end

def arabesque_pattern
  (0..8).step do |i|
    (0..8).each { |j| arabesque(90 * i + 30, 80 * j + 20, 80, 8, 5) }
  end
end

def circle_pattern
  (0..8).step do |i|
    (0..8).each { |j| circle(90 * i + 30, 80 * j + 20, 10) }
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
