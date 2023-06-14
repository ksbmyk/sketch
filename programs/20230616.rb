$base = 80
$split = 10
$colors = %w(#9be9a8 #40c463 #30a14e #216e39)

def setup
  createCanvas($base * $split, $base * $split)
  angleMode(DEGREES)
  background(255)
  noLoop
end

def draw
  30.times do
    draw_leaf(rand(1..10), rand(1..10))
  end
  draw_lotus_flower
end

def draw_leaf(x, y)
  push
  rotate(rand(1..9)*20)
  fill($colors[rand(0..3)])
  noStroke
  arc(x * 80 , - (y * 80), 160, 160, 0, 330)
  pop
end

def draw_lotus_flower
  push
  translate(200, 200)
  n = 12
  n.times do
    ellipse(0, 20, 10, 40)
    rotate(360/n)
  end
  pop
end

