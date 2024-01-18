# GENUARY 2024 jan17 "Inspired by Islamic art."
# https://genuary.art/prompts

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
  # 再帰がp5.rbだと重いので表示回数を減らす(rbCanvasでならもとの個数でも可能)
  # (0..8).step do |i|
  #   (0..8).each { |j| arabesque(90 * i, 80 * j, 100, 8, 5) }
  # end
  i = 3
  j = 3
  arabesque(90 * i, 80 * j, 100, 8, 5)
end

def circle_pattern
  # (0..8).step do |i|
  #   (0..8).each { |j| circle(90 * i, 80 * j, 10) }
  # end
  i = 3
  j = 3
  circle(90 * i, 80 * j, 10)
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
