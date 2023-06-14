$colors = %w(#9be9a8 #40c463 #30a14e #216e39)
def setup
  createCanvas(800, 800)
  angleMode(DEGREES)
  background('#a9ceec')
  noLoop
end

def draw
  100.times do
    draw_leaf(rand(1..10), rand(1..10))
  end

  5.times do
    draw_lotus_flower(rand(1..8), rand(1..8))
  end
end

def draw_leaf(x, y)
  push
  rotate(rand(1..9)*20)
  c = color($colors[rand(0..3)])
  c.setAlpha(200)
  fill(c)
  noStroke
  arc(x*80 , - y*80, 160, 160, 0, 330)
  pop
end

def draw_lotus_flower(x, y)
  push
  translate(x*100, y*100)
  rotate(rand(1..9)*20)
  c = color('#fef3ff')
  c.setAlpha(210)
  fill(c)
  noStroke
  n = 12
  n.times do
    ellipse(0, 20, 10, 40)
    rotate(360/n)
  end
  pop
end

