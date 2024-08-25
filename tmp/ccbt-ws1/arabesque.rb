
$n = 5
def setup
  createCanvas(200, 200)
  background(0)
  #noLoop # 外すとすごく重くなる
end
  
def draw
  background(0)

  stroke(100, rand(0..255), 255)
  strokeWeight(1)
  noFill
	
  arabesque_pattern($n)
  if $n == 7
    $n = 5
  else
    $n = $n + 1
  end

end

def arabesque_pattern(n)
	arabesque(100, 100, 100, n, rand(3..6))
end

  
def arabesque(x, y, radius, sides, depth)
  return if depth == 0
  
  beginShape()
  sides.to_i.times do |i|
    angle = map(i, 0, sides, 0, TWO_PI)
    new_x = x + cos(angle) * radius
    new_y = y + sin(angle) * radius
    vertex(new_x, new_y)
    
    next_radius = radius * 0.3 
    next_x = x + cos(angle) * next_radius
    next_y = y + sin(angle) * next_radius
    arabesque(next_x, next_y, next_radius, sides, depth - 1)
  end
  endShape(CLOSE)
end
